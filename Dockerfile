# Use the official PHP image with Apache
FROM php:8.2-apache

# Set working directory
WORKDIR /var/www/html

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    zip \
    unzip \
    nodejs \
    npm \ 
    default-mysql-client \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy application code
COPY . /var/www/html

# Copy existing application directory permissions
COPY --chown=www-data:www-data . /var/www/html

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader --no-scripts

# Install Node.js dependencies and build assets
RUN npm install && npm run build

# Create .env file if it doesn't exist
RUN if [ ! -f .env ]; then cp .env.example .env; fi

# Generate application key if not set
RUN php artisan key:generate --no-interaction --force

# Set permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html/storage \
    && chmod -R 755 /var/www/html/bootstrap/cache

# Configure Apache
RUN a2enmod rewrite
RUN echo '<VirtualHost *:80>\n\
    DocumentRoot /var/www/html/public\n\
    <Directory /var/www/html/public>\n\
        AllowOverride All\n\
        Require all granted\n\
    </Directory>\n\
    ErrorLog ${APACHE_LOG_DIR}/error.log\n\
    CustomLog ${APACHE_LOG_DIR}/access.log combined\n\
</VirtualHost>' > /etc/apache2/sites-available/000-default.conf

# Expose port 80
EXPOSE 80

# Create startup script
RUN echo '#!/bin/bash\n\
set -e\n\
\n\
update_env() {\n\
    local key=$1\n\
    local value=$2\n\
    if grep -q "^${key}=" .env; then\n\
        sed -i "s|^${key}=.*|${key}=${value}|" .env\n\
    else\n\
        echo "${key}=${value}" >> .env\n\
    fi\n\
}\n\
\n\
if [ ! -f .env ]; then\n\
    cp .env.example .env\n\
fi\n\
\n\
# Map environment variables to .env\n\
update_env "DB_HOST" "${DB_HOST:-mysql}"\n\
update_env "DB_PORT" "${DB_PORT:-3306}"\n\
update_env "DB_DATABASE" "${DB_DATABASE:-isellonline}"\n\
update_env "DB_USERNAME" "${DB_USERNAME:-isellonline_user}"\n\
update_env "DB_PASSWORD" "${DB_PASSWORD:-isellonline_password}"\n\
\n\
echo "--- Connection Debug ---"\n\
echo "Target: ${DB_HOST:-mysql}:${DB_PORT:-3306}"\n\
echo "User: ${DB_USERNAME:-isellonline_user}"\n\
\n\
for i in {1..30}; do\n\
    echo "Checking port ${DB_PORT:-3306} on ${DB_HOST:-mysql} (attempt $i/30)..."\n\
    if nc -z "${DB_HOST:-mysql}" "${DB_PORT:-3306}"; then\n\
        echo "Port is open! Checking credentials..."\n\
        if mysqladmin ping -h"${DB_HOST:-mysql}" -P"${DB_PORT:-3306}" -u"${DB_USERNAME:-isellonline_user}" -p"${DB_PASSWORD:-isellonline_password}" --silent; then\n\
            echo "Access Granted! MySQL is ready."\n\
            break\n\
        else\n\
            echo "Access Denied: Check your DB_USERNAME and DB_PASSWORD variables."\n\
        fi\n\
    else\n\
        echo "Port is closed: MySQL container may still be starting or host name is wrong."\n\
    fi\n\
\n\
    if [ $i -eq 30 ]; then\n\
        echo "Exceeded max attempts. Exiting."\n\
        exit 1\n\
    fi\n\
    sleep 2\n\
done\n\
\n\
php artisan migrate --force\n\
php artisan config:cache\n\
php artisan route:cache\n\
\n\
echo "Starting Apache..."\n\
apache2-foreground' > /usr/local/bin/start.sh

RUN chmod +x /usr/local/bin/start.sh

# Start the application
CMD ["/usr/local/bin/start.sh"]