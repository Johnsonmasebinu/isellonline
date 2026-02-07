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

# Raw port test using nc
echo "Testing raw TCP connection with nc..."
if nc -zv -w 5 $DB_HOST $DB_PORT; then
    echo "TCP connection to $DB_HOST:$DB_PORT succeeded!"
else
    echo "WARNING: TCP connection to $DB_HOST:$DB_PORT failed!"
fi

# Multi-attempt PHP connection check
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
