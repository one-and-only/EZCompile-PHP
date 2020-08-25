#!/bin/bash
sudo su
git checkout php-src

function compilePHP {
    # Install All Dependencies
    echo Installing Dependencies
    brew install flex autoconf automake libtool re2c bison
    echo Installed all Dependencies
    # Build the Configure Script
    echo Building configuration script
    ./buildconf
    echo Built Configuration Script
    # Configure PHP Installation
    echo Configuring PHP
    ./configure
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