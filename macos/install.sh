#!/bin/bash
sudo su &
git checkout php-src

function compilePHP {
    # Install All Dependencies
    echo Installing Dependencies
    brew install flex autoconf automake libtool re2c bison openssl curl enchant gd freetype mhash libiconv libsodium libjpeg pcre libxml2 argon2 tidy-html5 libzip
    # Export Packages to the $PATH so They can be Found by the System
    echo 'export PATH="/usr/local/opt/openssl/bin:$PATH"' >> /Users/antonios/.bash_profile
    source /Users/antonios/.bash_profile
    echo Installed all Dependencies
    # Build the Configure Script
    echo Building configuration script
    cd ..
    ./buildconf
    echo Built Configuration Script
    # Configure PHP Installation
    echo Configuring PHP
    ./configure --with-openssl --enable-bcmath --enable-calendar --with-curl --with-enchant --enable-ftp --enable-gd --with-webp --with-jpeg --with-freetype --with-mhash --with-iconv=/usr/local/Cellar/libiconv/1.16 --with-imap-ssl --enable-mbstring --enable-pdo --with-pdo-mysql=mysqlnd --enable-shmop --enable-soap --enable-sockets --with-sodium --with-password-argon2 --enable-sysvmsg --enable-sysvsem --enable-sysvshm --with-tidy --with-zip
    echo Configured PHP
    # Set the Job Count for make
    echo Setting job count for make
    THREADCOUNT=$(sysctl -n hw.ncpu)
    JOBCOUNT=$((THREADCOUNT+1))
    echo Set job count for make
    # Build PHP
    echo Building PHP
    make -j"$JOBCOUNT"
    echo Built PHP
    # Test PHP Commands and Test for Bugs
    echo Testing PHP
    make TEST_PHP_ARGS=-j"$JOBCOUNT" test
    echo Tested PHP
    TESTCHECK=$(echo $?)
    if [ "$TESTCHECK" = 0 ]; then
        echo Installing PHP-CLI
        make install
        echo PHP-CLI has now been installed
        exit 0
    elif [ "$TESTCHECK" = 1 ]; then
        read -p 'Some tests have not completed successfully. This can sometimes be ignored, but sometimes might need attention. Would you like to continue with installation?[y/Y/n/N] ' ERRORRESPONSE
        if [ "$ERRORRESPONSE" = y ] || [ "$ERRORRESPONSE" = Y ]; then
            echo Installing PHP-CLI
            make install
            echo Installed PHP-CLI
            exit 0
        elif [ "$ERRORRESPONSE" = n ] || [ "$ERRORRESPONSE" = N ]; then
            echo cancelled installation
            exit 130
        fi
    fi
}

brew help
BREWCHECK=$(echo $?)

if [ "$BREWCHECK" = 0 ]; then
    compilePHP
elif [ "$BREWCHECK" = 127 ]; then
    # Install Homebew Since it was not Found
    echo installing brew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    echo brew has been installed
    compilePHP
else
    echo There was an error checking for Homebrew support.
    exit 1
fi
git checkout master
exit 0
