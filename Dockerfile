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
# Ensure .env file exists\n\
if [ ! -f .env ]; then\n\
    echo "Creating .env file from example..."\n\
    cp .env.example .env\n\
fi\n\
\n\
# Generate app key if not set\n\
if ! grep -q "^APP_KEY=" .env || grep -q "^APP_KEY=$" .env; then\n\
    echo "Generating application key..."\n\
    php artisan key:generate --force\n\
fi\n\
\n\
# Wait for MySQL to be ready\n\
echo "Waiting for MySQL..."\n\
for i in {1..30}; do\n\
    if mysqladmin ping -h"${DB_HOST:-mysql}" -P"${DB_PORT:-3306}" -u"${DB_USERNAME:-isellonline_user}" -p"${DB_PASSWORD:-isellonline_password}" --silent 2>/dev/null; then\n\
        echo "MySQL is up - executing migrations"\n\
        break\n\
    fi\n\
    echo "MySQL is unavailable - attempt $i/30 - sleeping"\n\
    sleep 2\n\
done\n\
\n\
if [ $i -eq 30 ]; then\n\
    echo "MySQL connection failed after 30 attempts"\n\
    exit 1\n\
fi\n\
\n\
# Run migrations\n\
php artisan migrate --force\n\
\n\
# Clear and cache config\n\
php artisan config:cache\n\
php artisan route:cache\n\
php artisan view:cache\n\
\n\
echo "Starting Apache..."\n\
# Start Apache\n\
apache2-foreground' > /usr/local/bin/start.sh

RUN chmod +x /usr/local/bin/start.sh

# Start the application
CMD ["/usr/local/bin/start.sh"]