FROM php:7.2.33-apache
RUN apt-get update && apt-get install --no-install-recommends -y && apt-get install openssl curl zlib1g-dev enchant libsodium-dev libzip-dev bzip2 libcurl4-openssl-dev libssl-dev libpng-dev libgmp-dev libxml2-dev libenchant-dev libc-client2007e-dev libc-client-dev libkrb5-dev libonig-dev libedit-dev libtidy-dev libxslt-dev --no-install-recommends -y && rm -rf /var/lib/apt/lists/*
RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl && docker-php-ext-configure zip --with-libzip
RUN docker-php-ext-install bcmath calendar ctype curl enchant exif ftp gmp iconv imap intl mbstring pcntl pdo pdo_mysql readline shmop soap sockets sodium sysvmsg sysvsem sysvshm tidy tokenizer xsl zip -j"$(nproc)"
RUN ls /usr/local/lib/php/extensions/no-debug-non-zts-20170718/
RUN apt-get purge openssl curl zlib1g-dev enchant libsodium-dev libzip-dev bzip2 libcurl4-openssl-dev libssl-dev libpng-dev libgmp-dev libxml2-dev libenchant-dev libc-client2007e-dev libc-client-dev libkrb5-dev libonig-dev libedit-dev libtidy-dev libxslt-dev -y
EXPOSE 80 443