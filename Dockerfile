# Usar una imagen oficial de PHP con Apache
FROM php:8.2-apache

# Habilitar módulos de Apache
RUN a2enmod rewrite

# Instalar cliente de PostgreSQL y sus extensiones para PHP
RUN apt-get update \
    && apt-get install -y libpq-dev \
    && docker-php-ext-install pdo pdo_pgsql

# Instalar la extensión MySQLi para PHP
RUN docker-php-ext-install mysqli

# Establecer el directorio de trabajo a /var/www/html
WORKDIR /var/www/html

# Copiar los archivos PHP en el contenedor en /var/www/html
COPY HTML/ .
