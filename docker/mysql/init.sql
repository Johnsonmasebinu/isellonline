-- MySQL initialization script for ISellOnline
-- This script runs when the MySQL container starts for the first time

-- Create database if it doesn't exist (though docker-compose should handle this)
CREATE DATABASE IF NOT EXISTS isellonline CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Grant privileges to the application user
GRANT ALL PRIVILEGES ON isellonline.* TO 'isellonline_user'@'%';
FLUSH PRIVILEGES;