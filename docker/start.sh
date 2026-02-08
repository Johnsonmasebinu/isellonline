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

echo "  Routing Table:"
route -n || netstat -rn
echo "  IP Addr:"
ip addr | grep "inet "

# Multi-attempt PHP connection check
echo "Starting database connection attempts..."
php -r "
\$host = getenv('DB_HOST');
\$user = getenv('DB_USERNAME');
\$pass = getenv('DB_PASSWORD');
\$port = getenv('DB_PORT');
\$db   = getenv('DB_DATABASE');

for (\$i = 0; \$i < 20; \$i++) {
    try {
        \$dsn = \"mysql:host=\$host;port=\$port;dbname=\$db\";
        \$pdo = new PDO(\$dsn, \$user, \$pass, [
            PDO::ATTR_TIMEOUT => 5,
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION
        ]);
        echo \"Connected successfully to \$host:\$port!\\n\";
        exit(0);
    } catch (PDOException \$e) {
        echo \"Attempt \" . (\$i+1) . \": \" . \$e->getMessage() . \" (Port: \$port)\\n\";
        sleep(5);
    }
}
exit(1);
"

# Run migrations and cache configs
echo "Running migrations..."
php artisan migrate --force
echo "Caching configurations..."
php artisan config:cache
php artisan route:cache

echo "Starting Apache..."
exec apache2-foreground
