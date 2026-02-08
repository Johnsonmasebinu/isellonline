#!/bin/bash
set -e

# Wait for a bit to ensure network is ready
sleep 2

# Create .env from example if it doesn't exist
if [ ! -f .env ]; then
    echo "Creating .env from .env.example..."
    cp .env.example .env
fi

# Function to update .env values
update_env() {
    local key=$1
    local value=$2
    if grep -q "^${key}=" .env; then
        sed -i "s|^${key}=.*|${key}=${value}|" .env
    else
        echo "${key}=${value}" >> .env
    fi
}

# Set default database configuration for external MySQL service
# Values are used if environment variables are not already set
export DB_HOST=${DB_HOST:-"50.28.87.112"}
export DB_PORT=${DB_PORT:-"27018"}
export DB_DATABASE=${DB_DATABASE:-"ISellOnlineDB"}
export DB_USERNAME=${DB_USERNAME:-"ISellOnlineDB"}
export DB_PASSWORD=${DB_PASSWORD:-"ISellOnlineDB"}

echo "Configuring .env file with current environment..."
update_env "DB_HOST" "$DB_HOST"
update_env "DB_PORT" "$DB_PORT"
update_env "DB_DATABASE" "$DB_DATABASE"
update_env "DB_USERNAME" "$DB_USERNAME"
update_env "DB_PASSWORD" "$DB_PASSWORD"
update_env "APP_URL" "${APP_URL:-https://isellonline.website}"

# Generate APP_KEY if it's missing or empty
if ! grep -q "^APP_KEY=base64" .env || [ -z "$(grep "^APP_KEY=" .env | cut -d'=' -f2)" ]; then
    echo "Generating application key..."
    php artisan key:generate --force
fi

echo "Waiting for Database at $DB_HOST:$DB_PORT..."
echo "Connection Debug:"
echo "  Host: $DB_HOST"
echo "  Port: $DB_PORT"
echo "  User: $DB_USERNAME"
echo "  DB:   $DB_DATABASE"

echo "  Proxy variables:"
env | grep -i proxy || echo "     None"

echo "Network Diagnostics:"
echo "  1. Internet (8.8.8.8):"
ping -c 1 -W 2 8.8.8.8 > /dev/null 2>&1 && echo "     SUCCESS" || echo "     FAILED"

echo "  2. DNS (google.com):"
ping -c 1 -W 2 google.com > /dev/null 2>&1 && echo "     SUCCESS" || echo "     FAILED"

echo "  3. DB Host ($DB_HOST):"
ping -c 1 -W 2 $DB_HOST > /dev/null 2>&1 && echo "     SUCCESS" || echo "     FAILED"

echo "  4. MTU Test (1472 bytes):"
ping -c 1 -W 2 -s 1472 $DB_HOST > /dev/null 2>&1 && echo "     SUCCESS (MTU ok)" || echo "     FAILED (Possible MTU issue)"

echo "  5. Target Port ($DB_PORT):"
nc -znv -w 5 $DB_HOST $DB_PORT 2>&1 || echo "     FAILED (Timed out)"

echo "  6. Other Ports on $DB_HOST:"
for p in 3306 8443 80 443; do
    nc -znv -w 1 $DB_HOST $p 2>&1 | grep -q "succeeded" && echo "     NOTE: Port $p is OPEN"
done

echo "  7. Traceroute to $DB_HOST (Last 5 hops):"
traceroute -q 1 -w 1 -m 20 $DB_HOST | tail -n 5

echo "  7. Attempting to find internal database hosts..."
for h in mysql db isellonline-mysql; do
    if ping -c 1 -W 1 $h > /dev/null 2>&1; then
        echo "     NOTE: Internal host '$h' is reachable!"
    fi
done

echo "  Routing Table:"
route -n || netstat -rn
echo "  IP Addr:"
ip addr | grep "inet "

# Multi-attempt PHP connection check
echo "Starting database connection attempts..."
# We will try the user-provided IP first, then fallback to internal hosts on port 3306
php -r "
\$user  = getenv('DB_USERNAME');
\$pass  = getenv('DB_PASSWORD');
\$db    = getenv('DB_DATABASE');

// List of (host, port) pairs to try
\$targets = [
    ['myapps-isellonlinedb-diqya2', '3306'],
    [getenv('DB_HOST'), getenv('DB_PORT')],
    ['mysql', '3306'],
    ['isellonline-mysql', '3306'],
    ['db', '3306'],
    ['172.17.0.1', '3306']
];

foreach (\$targets as \$target) {
    list(\$host, \$port) = \$target;
    if (!\$host || !\$port) continue;
    
    echo \"Testing connection to \$host:\$port...\\n\";
    try {
        \$dsn = \"mysql:host=\$host;port=\$port;dbname=\$db\";
        \$pdo = new PDO(\$dsn, \$user, \$pass, [
            PDO::ATTR_TIMEOUT => 3,
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION
        ]);
        echo \"Connected successfully to \$host!\";
        
        // Update .env if we found a working connection
        if (\$host != getenv('DB_HOST') || \$port != getenv('DB_PORT')) {
            \$env = file_get_contents('.env');
            \$env = preg_replace('/^DB_HOST=.*$/m', 'DB_HOST=' . \$host, \$env);
            \$env = preg_replace('/^DB_PORT=.*$/m', 'DB_PORT=' . \$port, \$env);
            file_put_contents('.env', \$env);
            echo \" (Updated .env to \$host:\$port)\\n\";
        } else {
            echo \"\\n\";
        }
        exit(0);
    } catch (PDOException \$e) {
        echo \"Failed: \" . \$e->getMessage() . \"\\n\";
    }
}
echo \"WARNING: All database connection attempts failed. Continuing anyway...\\n\";
"

# Run migrations and cache configs
echo "Running migrations (this may fail if DB is still unreachable)..."
php artisan migrate --force || echo "Migration failed, skipping..."

echo "Caching configurations..."
php artisan config:cache
php artisan route:cache

echo "Starting Apache..."
exec apache2-foreground
