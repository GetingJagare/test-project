FROM php:8.3.14-apache

COPY --from=composer:latest usr/bin/composer /usr/bin/composer

WORKDIR /var/www/app

COPY app/ .

ENV PHP_MEMORY_LIMIT=512M
# Installing dependencies for the PHP modules
RUN apt-get update && apt-get install -y git sendmail zip libjpeg-dev libzip-dev libpng-dev libicu-dev libonig-dev libcurl4-gnutls-dev libxml2-dev libfreetype6-dev

# Installing additional PHP modules
RUN docker-php-ext-configure gd --with-jpeg
RUN docker-php-ext-install mysqli pdo pdo_mysql gd zip bcmath ctype intl mbstring opcache xml dom curl soap

RUN echo 'memory_limit = 2048M' >> /usr/local/etc/php/conf.d/docker-php-memlimit.ini;
RUN echo '\nmax_execution_time=300' >> /usr/local/etc/php/conf.d/base.ini;
RUN echo '\ndisplay_errors=On' >> /usr/local/etc/php/conf.d/base.ini;
RUN echo '\nupload_max_filesize=512M' >> /usr/local/etc/php/conf.d/base.ini;
RUN echo '\npost_max_size=1024M' >> /usr/local/etc/php/conf.d/base.ini;

RUN a2enmod rewrite