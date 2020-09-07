#!/bin/bash
set -x

function setup() {
    read -p 'Which PHP version would you like to install?[latest-7.1/latest-7.2/latest-7.3/default: latest-7.4/latest-8.0/latest-master/q (quit)] ' PHPINSTALLVERSION
    PHPINSTALLVERSION=${PHPINSTALLVERSION:-latest-7.4}

    # Setup Correct files depending on PHP installation version choice
    if [ "$PHPINSTALLVERSION" = latest-7.1 ]; then
        read -p 'latest-7.1 is outdated and has been superseded by latest-7.2. Would you like to continue installation?[y/Y/default: n/N] ' OUTDATEDCHOICE
        OUTDATEDCHOICE=${OUTDATEDCHOICE:-n}
        if [ "$OUTDATEDCHOICE" = y ] || [ "$OUTDATEDCHOICE" = Y ]; then
            cd ../../releases/ || exit
            ls latest-7.1
            ISFOLDERPRESENT=$?
            if [ "$ISFOLDERPRESENT" = 2 ]; then
                unzip php-src-php-7.1.32.zip -d latest-7.1
                cd latest-7.1 || exit
            elif [ "$ISFOLDERPRESENT" = 0 ]; then
                read -p 'There already is a folder with this version of PHP. Would you like to remove it?[default: n/N/y/Y] ' FOLDERCHOICE
                FOLDERCHOICE=${FOLDERCHOICE:-n}
                if [ "$FOLDERCHOICE" = y ] || [ "$FOLDERCHOICE" = Y ]; then
                    sudo rm -r latest-7.1
                    unzip php-src-php-7.1.32.zip -d latest-7.1
                    cd latest-7.1 || exit
                elif [ "$FOLDERCHOICE" = n ] || [ "$FOLDERCHOICE" = N ]; then
                    echo cancelling installation
                    setup
                else
                    echo invalid argument, exiting...
                    setup
                fi
            fi
        elif [ "$OUTDATEDCHOICE" = n ] || [ "$OUTDATEDCHOICE" = N ]; then
            echo cancelling installation
            setup
        else
            echo invalid argument, exiting...
            setup
        fi

    elif [ "$PHPINSTALLVERSION" = latest-7.2 ]; then
        read -p 'latest-7.2 is outdated and has been superseded by latest-7.3. Would you like to continue installation?[y/Y/default: n/N] ' OUTDATEDCHOICE
        OUTDATEDCHOICE=${OUTDATEDCHOICE:-n}
        if [ "$OUTDATEDCHOICE" = y ] || [ "$OUTDATEDCHOICE" = Y ]; then
            cd ../../releases/ || exit
            ls latest-7.2
            ISFOLDERPRESENT=$?
            if [ "$ISFOLDERPRESENT" = 2 ]; then
                unzip php-src-php-7.2.33.zip -d latest-7.2
                cd latest-7.2 || exit
            elif [ "$ISFOLDERPRESENT" = 0 ]; then
                read -p 'There already is a folder with this version of PHP. Would you like to remove it?[default: n/N/y/Y] ' FOLDERCHOICE
                FOLDERCHOICE=${FOLDERCHOICE:-n}
                if [ "$FOLDERCHOICE" = y ] || [ "$FOLDERCHOICE" = Y ]; then
                    sudo rm -r latest-7.2
                    unzip php-src-php-7.2.33.zip -d latest-7.2
                    cd latest-7.2 || exit
                elif [ "$FOLDERCHOICE" = n ] || [ "$FOLDERCHOICE" = N ]; then
                    echo cancelling installation
                    setup
                else
                    echo invalid argument, exiting...
                    setup
                fi
            fi
        elif [ "$OUTDATEDCHOICE" = n ] || [ "$OUTDATEDCHOICE" = N ]; then
            echo cancelling installation
            setup
        else
            echo invalid argument, exiting...
            setup
        fi
    elif [ "$PHPINSTALLVERSION" = latest-7.3 ]; then
        read -p 'latest-7.3 is outdated and has been superseded by latest-7.4. Would you like to continue installation?[y/Y/default: n/N] ' OUTDATEDCHOICE
        OUTDATEDCHOICE=${OUTDATEDCHOICE:-n}
        if [ "$OUTDATEDCHOICE" = y ] || [ "$OUTDATEDCHOICE" = Y ]; then
            cd ../../releases/ || exit
            ls latest-7.3
            ISFOLDERPRESENT=$?
            if [ "$ISFOLDERPRESENT" = 2 ]; then
                unzip php-src-php-7.3.22RC1.zip -d latest-7.3
                cd latest-7.3 || exit
            elif [ "$ISFOLDERPRESENT" = 0 ]; then
                read -p 'There already is a folder with this version of PHP. Would you like to remove it?[default: n/N/y/Y] ' FOLDERCHOICE
                FOLDERCHOICE=${FOLDERCHOICE:-n}
                if [ "$FOLDERCHOICE" = y ] || [ "$FOLDERCHOICE" = Y ]; then
                    sudo rm -r latest-7.3
                    unzip php-src-php-7.3.22RC1.zip -d latest-7.3
                    cd latest-7.3 || exit
                elif [ "$FOLDERCHOICE" = n ] || [ "$FOLDERCHOICE" = N ]; then
                    echo cancelling installation
                    setup
                else
                    echo invalid argument, exiting...
                    setup
                fi
            fi
        elif [ "$OUTDATEDCHOICE" = n ] || [ "$OUTDATEDCHOICE" = N ]; then
            echo cancelling installation
            setup
        else
            echo invalid argument, exiting...
            setup
        fi
    elif [ "$PHPINSTALLVERSION" = latest-7.4 ]; then
        cd ../../releases/ || exit
        ls latest-7.4
        ISFOLDERPRESENT=$?
        if [ "$ISFOLDERPRESENT" = 2 ]; then
            unzip php-src-php-7.4.10RC1.zip -d latest-7.4
            cd latest-7.4 || exit
        elif [ "$ISFOLDERPRESENT" = 0 ]; then
            read -p 'There already is a folder with this version of PHP. Would you like to remove it?[default: n/N/y/Y] ' FOLDERCHOICE
            FOLDERCHOICE=${FOLDERCHOICE:-n}
            if [ "$FOLDERCHOICE" = y ] || [ "$FOLDERCHOICE" = Y ]; then
                sudo rm -r latest-7.4
                unzip php-src-php-7.4.10RC1.zip -d latest-7.4
                cd latest-7.4 || exit
            elif [ "$FOLDERCHOICE" = n ] || [ "$FOLDERCHOICE" = N ]; then
                echo cancelling installation
                setup
            else
                echo invalid argument, exiting...
                setup
            fi
        fi
    elif [ "$PHPINSTALLVERSION" = latest-8.0 ]; then
        read -p 'This a BETA PHP version and. This software has been tested, but bugs and errors are bound to appear in this early stage. This should not be used in a production environment. Are you sure you want to install?[y/Y/default: n/N] ' INSTALLCHOICE
        INSTALLCHOICE=${INSTALLCHOICE:-n}

        if [ "$INSTALLCHOICE" = y ] || [ "$INSTALLCHOICE" = Y ]; then
            cd ../../releases/ || exit
            ls latest-8.0
            ISFOLDERPRESENT=$?
            if [ "$ISFOLDERPRESENT" = 2 ]; then
                unzip php-src-php-8.0.0beta2.zip -d latest-8.0
                cd latest-8.0 || exit
            elif [ "$ISFOLDERPRESENT" = 0 ]; then
                read -p 'There already is a folder with this version of PHP. Would you like to remove it?[default: n/N/y/Y] ' FOLDERCHOICE
                FOLDERCHOICE=${FOLDERCHOICE:-n}
                if [ "$FOLDERCHOICE" = y ] || [ "$FOLDERCHOICE" = Y ]; then
                    sudo rm -r latest-8.0
                    unzip php-src-php-8.0.0beta2.zip -d latest-8.0
                    cd latest-8.0 || exit
                elif [ "$FOLDERCHOICE" = n ] || [ "$FOLDERCHOICE" = N ]; then
                    echo cancelling installation
                    setup
                else
                    echo invalid argument, exiting...
                    setup
                fi
            fi
        elif [ "$INSTALLCHOICE" = n ] || [ "$INSTALLCHOICE" = N ]; then
            echo cancelling installation
            setup
        else
            echo invalid argument, exiting...
            setup
        fi
    elif [ "$PHPINSTALLVERSION" = latest-master ]; then
        read -p 'CAREFUL: This is a pre-release version and is in heavy development. Install this only if you want the latest bleeding-edge features. These may not have been tested thoroughly and should not be used in a production environment. Are you sure you want to install?[y/Y/default: n/N] ' INSTALLCHOICE
        INSTALLCHOICE=${INSTALLCHOICE:-n}
        if [ "$INSTALLCHOICE" = y ] || [ "$INSTALLCHOICE" = Y ]; then
            cd ../../releases/ || exit
            sudo rm -r php-src
            git clone https://github.com/php/php-src.git
            cd php-src || exit
        elif [ "$INSTALLCHOICE" = n ] || [ "$INSTALLCHOICE" = N ]; then
            echo cancelling installation
            git chekout master
            setup
        else
            echo invalid argument, exiting...
            git checkout master
            setup
        fi
    elif [ "$PHPINSTALLVERSION" = q ] || [ "$PHPINSTALLVERSION" = quit ]; then
        echo cancelling installation
        exit 130
    fi

    # Install dependencies using APT
    # Code goes below for installing dependencies
    PREVDIR=$(pwd)
    echo installing dependencies
    mkdir iconvSRC
    cd iconvSRC || exit
    ICONVSRCDIR=$(pwd)
    wget http://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.16.tar.gz
    tar -xvzf libiconv-1.16.tar.gz
    cd libiconv-1.16 || exit
    ./configure --prefix=/usr/local/libiconv
    make
    sudo make install
    cd "$ICONVSRCDIR" || exit
    cd ..
    sudo rm -r iconvSRC
    cd "$PREVDIR" || exit
    sudo apt-get install -y pkg-config build-essential autoconf bison re2c \
        libxml2-dev libsqlite3-dev openssl libssl-dev libcurl4-openssl-dev libenchant-dev libpng-dev libwebp-dev libjpeg-dev libfreetype6-dev libonig-dev libsodium-dev libtidy-dev libzip-dev
    # Go into the right directory depending on PHP installation version
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
    elif [ "$PHPINSTALLVERSION" = latest-master ]; then
        cd .
    fi
}

# Configure PHP (./buildconf and ./configure)
function configure() {
    echo Building configuration script
    # Build the configure script
    sudo ./buildconf --force || exit
    echo Built Configuration Script
    # Configure PHP Installation
    echo Configuring PHP
    # Configure PHP per install version choice
    if [ "$PHPINSTALLVERSION" = latest-8.0 ] || [ "$PHPINSTALLVERSION" = latest-master ]; then
        sudo ./configure --with-openssl=/usr/lib/ssl --enable-bcmath --enable-calendar --with-curl --with-enchant --enable-ftp --enable-gd --with-webp --with-jpeg --with-freetype --with-mhash --with-iconv=/usr/local/libiconv --with-imap-ssl --enable-mbstring --enable-pdo --with-pdo-mysql=mysqlnd --enable-shmop --enable-soap --enable-sockets --with-sodium --with-password-argon2 --enable-sysvmsg --enable-sysvsem --enable-sysvshm --with-tidy --with-zip || exit
    elif [ "$PHPINSTALLVERSION" = latest-7.4 ]; then
        sudo ./configure --with-openssl --enable-bcmath --enable-calendar --with-curl --enable-ftp --enable-gd --with-webp --with-jpeg --with-freetype --with-mhash --with-iconv=/usr/local/libiconv --with-imap-ssl --enable-mbstring --enable-pdo --with-pdo-mysql=mysqlnd --enable-shmop --enable-soap --enable-sockets --with-sodium --with-password-argon2 --enable-sysvmsg --enable-sysvsem --enable-sysvshm --with-tidy --with-zip || exit
    elif [ "$PHPINSTALLVERSION" = latest-7.3 ]; then
        sudo ./configure --with-openssl --enable-bcmath --enable-calendar --with-curl --enable-ftp --enable-gd --with-webp --with-jpeg --with-freetype --with-mhash --without-iconv --with-imap-ssl --enable-mbstring --enable-pdo --with-pdo-mysql=mysqlnd --enable-shmop --enable-soap --enable-sockets --with-sodium --with-password-argon2 --enable-sysvmsg --enable-sysvsem --enable-sysvshm --with-zip || exit
    elif [ "$PHPINSTALLVERSION" = latest-7.2 ]; then
        sudo ./configure --with-openssl --enable-bcmath --enable-calendar --with-curl --enable-ftp --with-mhash --without-iconv --with-imap-ssl --enable-mbstring --enable-pdo --with-pdo-mysql=mysqlnd --enable-shmop --enable-soap --enable-sockets --with-sodium --with-password-argon2 --enable-sysvmsg --enable-sysvsem --enable-sysvshm || exit
    elif [ "$PHPINSTALLVERSION" = latest-7.1 ]; then
        sudo ./configure --with-openssl --enable-bcmath --enable-calendar --with-curl --enable-ftp --with-mhash --without-iconv --with-imap-ssl --enable-mbstring --enable-pdo --with-pdo-mysql=mysqlnd --enable-shmop --enable-soap --enable-sockets --enable-sysvmsg --enable-sysvsem --enable-sysvshm || exit
    fi
    echo Configured PHP
}

# Build PHP (make)
function build() {
    # Set the Job Count for make
    echo Setting job count for make
    # Set the make job count for the lowest buid time
    THREADCOUNT=$(grep -c ^processor /proc/cpuinfo)
    JOBCOUNT=$((THREADCOUNT + 1))
    echo Set job count for make
    # Build PHP
    echo Building PHP
    # Build PHP using make
    sudo make -j"$JOBCOUNT" || exit
    echo Built PHP
}

# Test PHP (make test)
function test() {
    echo Testing PHP
    # Test PHP per PHP version choice
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
}

# Install PHP CLI (make install)
function installCLI() {
    # Ask the user if the PHP CLI should be installed or not
    read -p 'The tests have been completed and you may or may not have had failures on some of them. This can sometimes be ignored with the latest builds, or may need extra attention. Would you like to continue with installation?[default: y/Y/n/N] ' ERRORRESPONSE
    ERRORRESPONSE=${ERRORRESPONSE:-y}
    if [ "$ERRORRESPONSE" = y ] || [ "$ERRORRESPONSE" = Y ]; then
        # Install PHP CLI
        echo Installing PHP-CLI
        sudo make install || exit
        echo Installed PHP-CLI
        exit 0
    elif [ "$ERRORRESPONSE" = n ] || [ "$ERRORRESPONSE" = N ]; then
        # Cancel install, go back to setup
        echo cancelled installation
        git checkout master
        setup
    fi
}

setup
configure
build
test
installCLI
exit 0
