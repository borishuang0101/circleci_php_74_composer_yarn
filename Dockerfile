FROM composer:2 AS composer

FROM circleci/php:7.4.9
USER root
COPY --from=composer /usr/bin/composer /usr/bin/composer
RUN echo "deb http://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-key adv --fetch-keys http://dl.yarnpkg.com/debian/pubkey.gpg
RUN apt-get update && apt-get install -y git ruby-full zlib1g-dev libxml2-dev libfreetype6-dev libjpeg62-turbo-dev libpng-dev libzip-dev libgmp-dev
RUN docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/
RUN docker-php-ext-install zip pdo_mysql soap gd pcntl shmop
RUN docker-php-ext-configure gmp 
RUN docker-php-ext-install gmp
RUN docker-php-ext-install sockets
RUN apt install -y -qq curl
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install -y -qq nodejs gnupg2 gcc g++
RUN apt-get install -y -qq yarn --no-install-recommends
CMD ["/bin/bash"]
