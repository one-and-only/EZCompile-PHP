FROM php:7.4.10-apache
RUN apt-get update && apt-get upgrade -y
RUN apt-get install openssl curl zlib1g-dev enchant libsodium-dev libzip-dev bzip2 libcurl4-openssl-dev libssl-dev libpng-dev libgmp-dev libxml2-dev libenchant-dev libc-client2007e-dev libc-client-dev libkrb5-dev libonig-dev libedit-dev libtidy-dev libxslt-dev libgd-dev -y
RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl
RUN docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/
RUN docker-php-ext-install bcmath calendar ctype curl enchant exif ffi ftp gd gmp iconv imap intl mbstring pcntl pdo pdo_mysql readline shmop soap sockets sodium sysvmsg sysvsem sysvshm tidy tokenizer xsl zip -j$(nproc)
RUN ls /usr/local/lib/php/extensions/no-debug-non-zts-20190902/
RUN a2enmod rewrite
EXPOSE 80
