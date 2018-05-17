FROM php:7.1-apache

# install all the system dependencies and enable PHP modules
RUN apt-get update && apt-get install -y \
    zlib1g-dev \
    git \
    zip \
    unzip \
    nano \
    sqlite3 libsqlite3-dev \
    && rm -r /var/lib/apt/lists/* \
    && docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd \
    && docker-php-ext-install \
    pdo_mysql \
    zip



# install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

# set our application folder as an environment variable
ENV APP_HOME /var/www/html

# change the web_root to laravel /var/www/html/public folder
RUN sed -i -e "s/html/html\/public/g" /etc/apache2/sites-enabled/000-default.conf

# enable apache module rewrite
RUN a2enmod rewrite

COPY ./composer.* $APP_HOME/
WORKDIR $APP_HOME

# install all PHP dependencies, but do not run scripts
RUN composer install --no-dev --no-interaction --no-autoloader

# copy complete source files and run composer
COPY . $APP_HOME

# install all PHP dependencies
RUN composer dump-autoload --no-dev --no-interaction --optimize

# change ownership of our applications
RUN chown www-data:www-data /var/www/html/storage/framework/views



