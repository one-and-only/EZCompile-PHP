#!/bin/bash

function compilePHP {
    # Install All Dependencies
    read -p 'Which PHP version would you like to install?[latest-7.1/latest-7.2/latest-7.3/latest-7.4/latest-8.0/latest-master] ' PHPINSTALLVERSION

    if [ "$PHPINSTALLVERSION" = latest-7.1 ]; then
        cd ../releases/ || exit
        unzip php-src-php-7.1.32.zip -d latest-7.1
        cd latest-7.1 || exit
    elif [ "$PHPINSTALLVERSION" = latest-7.2 ]; then
        cd ../releases/ || exit
        unzip php-src-php-7.2.33.zip -d latest-7.2
        cd latest-7.2 || exit
    elif [ "$PHPINSTALLVERSION" = latest-7.3 ]; then
        cd ../releases/ || exit
        unzip php-src-php-7.3.22RC1.zip -d latest-7.3
        cd latest-7.3 || exit
    elif [ "$PHPINSTALLVERSION" = latest-7.4 ]; then
        cd ../releases/ || exit
        unzip php-src-php-7.4.10RC1.zip -d latest-7.4
        cd latest-7.4 || exit
    elif [ "$PHPINSTALLVERSION" = latest-8.0 ]; then
        read -p 'This a BETA PHP version. This software has been tested, but bugs and errors are bound to appear in this early stage. This should not be used in a production environment. Are you sure you want to install?[y/Y/n/N] ' INSTALLCHOICE
        if [ "$INSTALLCHOICE" = y ] || [ "$INSTALLCHOICE" = Y ]; then
            cd ../releases/ || exit
            unzip php-src-php-8.0.0beta2.zip -d latest-8.0
            cd latest-8.0 || exit
        elif [ "$INSTALLCHOICE" = n ] || [ "$INSTALLCHOICE" = N ]; then
            echo cancelling installation
            exit 130
        else
            echo invalid argument, exiting...
            exit 1
        fi
    elif [ "$PHPINSTALLVERSION" = latest-master ]; then
        read -p 'CAREFUL: This is a pre-release version and is in heavy development. Install this only if you want the latest bleeding-edge features. These may not have been tested thoroughly and should not be used in a production environment. Are you sure you want to install?[y/Y/n/N] ' INSTALLCHOICE
        if [ "$INSTALLCHOICE" = y ] || [ "$INSTALLCHOICE" = Y ]; then
            git checkout php-src
        elif [ "$INSTALLCHOICE" = n ] || [ "$INSTALLCHOICE" = N ]; then
            echo cancelling installation
            exit 130
        else
            echo invalid argument, exiting...
            exit 1
        fi
    fi

    echo Installing Dependencies
    brew install flex autoconf automake libtool re2c bison openssl curl enchant gd freetype mhash libiconv libsodium libjpeg pcre libxml2 argon2 tidy-html5 libzip
    # Export Packages to the $PATH so They can be Found by the System
    sudo echo 'export PATH="/usr/local/opt/openssl/bin:$PATH"' >> ~/.bash_profile
    source ~/.bash_profile
    echo Installed all Dependencies
    # Build the Configure Script
    echo Building configuration script

    if [ "$PHPINSTALLVERSION" = latest-7.1 ]; then
        cd php-src-php-7.1.32/ || exit
    elif [ "$PHPINSTALLVERSION" = latest-7.2 ]; then
        cd php-src-php-7.2.33/ || exit
    elif [ "$PHPINSTALLVERSION" = latest-7.3 ]; then
        cd php-src-php-7.3.22RC1/ || exit
    elif [ "$PHPINSTALLVERSION" = latest-7.4 ]; then
        cd php-src-php-7.4.10RC1/ || exit
    elif [ "$PHPINSTALLVERSION" = latest-8.0 ]; then
        cd php-src-php-8.0.0beta2/ || exit
    fi

    sudo ./buildconf --force || exit
    echo Built Configuration Script
    # Configure PHP Installation
    echo Configuring PHP
    if [ "$PHPINSTALLVERSION" = latest-8.0 ] || [ "$PHPINSTALLVERSION" = latest-master ]; then
        sudo ./configure --with-openssl --enable-bcmath --enable-calendar --with-curl --with-enchant --enable-ftp --enable-gd --with-webp --with-jpeg --with-freetype --with-mhash --with-iconv=/usr/local/Cellar/libiconv/1.16 --with-imap-ssl --enable-mbstring --enable-pdo --with-pdo-mysql=mysqlnd --enable-shmop --enable-soap --enable-sockets --with-sodium --with-password-argon2 --enable-sysvmsg --enable-sysvsem --enable-sysvshm --with-tidy --with-zip || exit
    elif [ "$PHPINSTALLVERSION" = latest-7.4 ]; then
        sudo ./configure --with-openssl --enable-bcmath --enable-calendar --with-curl --enable-ftp --enable-gd --with-webp --with-jpeg --with-freetype --with-mhash --with-iconv=/usr/local/Cellar/libiconv/1.16 --with-imap-ssl --enable-mbstring --enable-pdo --with-pdo-mysql=mysqlnd --enable-shmop --enable-soap --enable-sockets --with-sodium --with-password-argon2 --enable-sysvmsg --enable-sysvsem --enable-sysvshm --with-tidy --with-zip || exit
    elif [ "$PHPINSTALLVERSION" = latest-7.3 ]; then
        sudo ./configure --with-openssl --enable-bcmath --enable-calendar --with-curl --enable-ftp --enable-gd --with-webp --with-jpeg --with-freetype --with-mhash --without-iconv --with-imap-ssl --enable-mbstring --enable-pdo --with-pdo-mysql=mysqlnd --enable-shmop --enable-soap --enable-sockets --with-sodium --with-password-argon2 --enable-sysvmsg --enable-sysvsem --enable-sysvshm --with-zip || exit
    elif [ "$PHPINSTALLVERSION" = latest-7.2 ]; then
        sudo ./configure --with-openssl --enable-bcmath --enable-calendar --with-curl --enable-ftp --with-mhash --without-iconv --with-imap-ssl --enable-mbstring --enable-pdo --with-pdo-mysql=mysqlnd --enable-shmop --enable-soap --enable-sockets --with-sodium --with-password-argon2 --enable-sysvmsg --enable-sysvsem --enable-sysvshm || exit
    elif [ "$PHPINSTALLVERSION" = latest-7.1 ]; then
        sudo ./configure --with-openssl --enable-bcmath --enable-calendar --with-curl --enable-ftp --with-mhash --without-iconv --with-imap-ssl --enable-mbstring --enable-pdo --with-pdo-mysql=mysqlnd --enable-shmop --enable-soap --enable-sockets --enable-sysvmsg --enable-sysvsem --enable-sysvshm || exit
    fi
    echo Configured PHP
    # Set the Job Count for make
    echo Setting job count for make
    THREADCOUNT=$(sysctl -n hw.ncpu)
    JOBCOUNT=$((THREADCOUNT+1))
    echo Set job count for make
    # Build PHP
    echo Building PHP
    sudo make -j"$JOBCOUNT" || exit
    echo Built PHP

    # Test PHP Commands and Test for Bugs
    echo Testing PHP
    if [ "$PHPINSTALLVERSION" = latest-8.0 ] || [ "$PHPINSTALLVERSION" = latest-master ] || [ "$PHPINSTALLVERSION" = latest-7.4 ]; then
        sudo make TEST_PHP_ARGS=-j"$JOBCOUNT" test
    elif [ "$PHPINSTALLVERSION" = latest-7.3 ]; then
        sudo make test -j"$JOBCOUNT"
    elif [ "$PHPINSTALLVERSION" = latest-7.2 ]; then
        sudo make test -j"$JOBCOUNT"
    elif [ "$PHPINSTALLVERSION" = latest-7.1 ]; then
        sudo make test -j"$JOBCOUNT"
    fi  
    
    echo Tested PHP
    read -p 'The tests have been completed and you may or may not have had failures on some of them. This can sometimes be ignored with the latest builds, or may need extra attention. Would you like to continue with installation?[y/Y/n/N] ' ERRORRESPONSE
    if [ "$ERRORRESPONSE" = y ] || [ "$ERRORRESPONSE" = Y ]; then
        echo Installing PHP-CLI
        sudo make install || exit
        echo Installed PHP-CLI
        git checkout master
        exit 0
    elif [ "$ERRORRESPONSE" = n ] || [ "$ERRORRESPONSE" = N ]; then
        echo cancelled installation
        git checkout master
        exit 130
    fi
}

    brew help
    BREWCHECK=$(echo $?)

if [ "$BREWCHECK" = 0 ]; then
    compilePHP
elif [ "$BREWCHECK" = 127 ]; then
    # Install Homebew Since it was not Found
    echo installing brew
    sudo /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    echo brew has been installed
    compilePHP
else
    echo There was an error checking for Homebrew support.
    git checkout master
    exit 1
fi
git checkout master
exit 0
