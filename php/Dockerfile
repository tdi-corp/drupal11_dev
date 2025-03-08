FROM php:8.3-fpm

WORKDIR /var/www/html

RUN apt-get update && apt-get install -y libgmp-dev \
        libzip-dev \
        zip \
        libpng-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
	&& docker-php-ext-install zip \
	&& docker-php-ext-install mysqli pdo pdo_mysql \
	&& docker-php-ext-install bcmath pcntl \
	&& docker-php-ext-configure gmp \
	&& docker-php-ext-install gmp \
	&& docker-php-ext-configure opcache --enable-opcache \
	&& docker-php-ext-install opcache \
	&& docker-php-ext-install gd \
	&& apt-get -y install cron \
	&& apt-get -y install sudo \
	&& apt-get -y install supervisor \
	# && apt-get -y install npm \
	&& pecl update-channels && pecl install mcrypt-1.0.7 && docker-php-ext-enable mcrypt \
	&& chown -R www-data:www-data /var/www/html
#RUN pecl install xdebug \
#    	&& docker-php-ext-enable xdebug

COPY --from=composer:2.5.8 /usr/bin/composer /usr/bin/composer

# Add crontab file in the cron directory
ADD crontab /etc/cron.d/hello-cron

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/hello-cron

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

RUN crontab /etc/cron.d/hello-cron

COPY . .

# Copy Entrypoint script in the container
COPY start.sh /
RUN ["chmod", "+x", "/start.sh"]
CMD ["/start.sh","php-fpm","-F"]