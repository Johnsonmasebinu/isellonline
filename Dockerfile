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
RUN printf "#!/bin/bash\n\
set -e\n\
\n\
sleep 2\n\
\n\
if [ ! -f .env ]; then\n\
    cp .env.example .env\n\
fi\n\
\n\
update_env() {\n\
    local key=\$1\n\
    local value=\$2\n\
    if grep -q \"^\${key}=\" .env; then\n\
        sed -i \"s|^\${key}=.*|\${key}=\${value}|\" .env\n\
    else\n\
        echo \"\${key}=\${value}\" >> .env\n\
    fi\n\
}\n\
\n\
# Set default database configuration for external MySQL service\n\
# Uses Dockploy external database service\n\
if [ -z \"\$DB_HOST\" ]; then\n\
    export DB_HOST=\"50.28.87.112\"\n\
fi\n\
if [ -z \"\$DB_PORT\" ]; then\n\
    export DB_PORT=\"8443\"\n\
fi\n\
if [ -z \"\$DB_DATABASE\" ]; then\n\
    export DB_DATABASE=\"isellonline_db\"\n\
fi\n\
if [ -z \"\$DB_USERNAME\" ]; then\n\
    export DB_USERNAME=\"isellonline_db\"\n\
fi\n\
if [ -z \"\$DB_PASSWORD\" ]; then\n\
    export DB_PASSWORD=\"isellonline_db\"\n\
fi\n\
\n\
echo \"Configuring .env file...\"\n\
update_env \"DB_HOST\" \"\$DB_HOST\"\n\
update_env \"DB_PORT\" \"\$DB_PORT\"\n\
update_env \"DB_DATABASE\" \"\$DB_DATABASE\"\n\
update_env \"DB_USERNAME\" \"\$DB_USERNAME\"\n\
update_env \"DB_PASSWORD\" \"\$DB_PASSWORD\"\n\
update_env \"APP_URL\" \"\${APP_URL:-https://isellonline.website}\"\n\
\n\
if ! grep -q \"^APP_KEY=base64\" .env; then\n\
    php artisan key:generate --force\n\
fi\n\
\n\
echo \"Waiting for Database at \$DB_HOST...\"\n\
\n\
php -r \"\n\
\\\$host = getenv('DB_HOST');\n\
\\\$user = getenv('DB_USERNAME');\n\
\\\$pass = getenv('DB_PASSWORD');\n\
\n\
for (\\\$i = 0; \\\$i < 60; \\\$i++) {\n\
    try {\n\
        \\\$pdo = new PDO(\\\"mysql:host=\\\$host;port=3306\\\", \\\$user, \\\$pass);\n\
        echo \\\"Connected successfully!\\\\n\\\";\n\
        exit(0);\n\
    } catch (PDOException \\\$e) {\n\
        echo \\\"Attempt \\\" . (\\\$i+1) . \\\": \\\" . \\\$e->getMessage() . \\\"\\\\n\\\";\n\
        sleep(2);\n\
    }\n\
}\n\
exit(1);\n\
\"\n\
\n\
php artisan migrate --force\n\
php artisan config:cache\n\
php artisan route:cache\n\
\n\
echo \"Starting Management...\"\n\
apache2-foreground" > /usr/local/bin/start.sh

RUN chmod +x /usr/local/bin/start.sh

# Start the application
CMD ["/usr/local/bin/start.sh"]