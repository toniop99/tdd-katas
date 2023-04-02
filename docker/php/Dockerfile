FROM php:8.2-apache

WORKDIR /usr/src/app

RUN apt update && apt install -y \
    bash \
    git \
    curl \
    wget \
    zip \
    unzip

 RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --filename=composer \
    && php -r "unlink('composer-setup.php');" \
    && mv composer /usr/local/bin/composer
