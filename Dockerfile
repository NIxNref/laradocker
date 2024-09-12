# Use the official PHP image with Apache
FROM php:8.3-apache

# Install dependencies
RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev libzip-dev unzip git
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd zip pdo pdo_mysql

# Set the working directory
WORKDIR /var/www/html

# Copy the Laravel application
COPY . .

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install PHP dependencies
RUN composer install

# Expose port 80
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
