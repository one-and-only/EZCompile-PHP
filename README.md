# EZCompile-PHP

## 

### The Easy way to compile and install PHP on MacOS, Windows, and Linux

### Status: pre-release, HEAVY DEVELOPMENT

### Installs: PHP CLI (latest-7.1-latest-master (including 8.0-betaX) Version, MacOS and Debian ONLY) and can setup a Docker Application for PHP-7.4.9, Apache-2.4.38, and MySQL-8.0.21 combined)

![GitHub release (latest by date including pre-releases)](https://img.shields.io/github/v/release/one-and-only/EZCompile-PHP?color=yellow&include_prereleases&label=latest)
[![Codacy Badge](https://app.codacy.com/project/badge/Grade/3e4760ea322048cdbb90652c6fbb8d9b)](https://www.codacy.com/manual/one-and-only/EZCompile-PHP?utm_source=github.com&utm_medium=referral&utm_content=one-and-only/EZCompile-PHP&utm_campaign=Badge_Grade)

## How to Install PHP CLI (_macOS and Debian ONLY_)

* * *

### macOS

1.  Open Terminal and navigate to `[GITHUB-REPO-DIR]/macos/CLI/` with `[GITHUB-REPO-DIR]` being the directory of this repository (`cd [GITHUB-REPO-DIR]/macos/CLI/`).

2.  Execute the install script that is inside the above directory by typing `./install.sh`. This will install Homebrew if it not already installed, install all dependencies required for compiling the PHP CLI, compile the PHP CLI itself, test the build, and then install it. Do **_NOT_** run it with `sudo ./install.sh` even if you will be asked later on about your password. This is because Homebrew can't run as admin.

    -   You're able to choose the version of PHP you want to install between the latest releases of PHP 7.1, 7.2, 7.3, 7.4, 8.0-betaX, and the latest version of the master PHP branch.
    -   You will be prompted to choose a version at the beginning of the program. There are other prompts inside of the program, but those should be really self-explanatory.

3.  After PHP CLI has been successfully installed, you can check that it has applied by executing `php -v`. This will show you the PHP CLI version along with the build date and other information. The build version and date is what you need to pay attention to make sure it installed correctly. You're done!

### Debian

1.  Open Terminal and navigate to `[GITHUB-REPO-DIR]/debian/CLI/` with `[GITHUB-REPO-DIR]` being the directory of this repository (`cd [GITHUB-REPO-DIR]/debian/CLI/`).

2.  Execute the install script that is inside the above directory by typing `./install.sh`. This will install all dependencies required to compile the PHP CLI using the Advanced Package Tool (APT), compile the PHP CLI itself, test the build, and then install it. If you so wish, you may run with `sudo ./install.sh` unlike macOS in order to get asked for your admin password once at the start, so you can leave it unattended longer.

    -   You're able to choose the version of PHP you want to install between the latest releases of PHP 7.1, 7.2, 7.3, 7.4, 8.0-betaX, and the latest version of the master PHP branch.
    -   You will be prompted to choose a version at the beginning of the program. There are other prompts inside of the program, but those should be really self-explanatory.

3.  After PHP CLI has been successfully installed, you can check that it has applied by executing `php -v`. This will show you the PHP CLI version along with the build date and other information. The build version and date is what you need to pay attention to make sure it installed correctly. You're done!

## Installing the Docker Web Server Application (_All Major OSes_)

* * *

## A. macOS (10.13 High Sierra+)

## To install Docker

1.  Navigate to `[GITHUB-REPO-DIR]/macos/Docker/dockerDesktop` with `[GITHUB-REPO-DIR]` being the directory of the repository (`cd [GITHUB-REPO-DIR]/debian/Docker/dockerd`)

2.  execute the install script `installDockerDesktop.sh` (`./installDockerDesktop.sh`). Enter your password when prompted, and wait for it to finish. This will install Docker Desktop and all dependencies. It will _NOT_ overwrite a current install if it is found, but instead will ask you if you want it removed.

## To Install and Run your Web Server

3.  Choose your Web Server Software. You have a choice to run a full LAMP stack, only MySQL, or only PHP. You can choose between PHP 7.2, 7.3, 7.4, or 8.0-betaX and MySQL 5.6, 5.7, and 8.0

### Start Docker

4.  Simply start Docker Desktop by launching it as a normal application. It is currently called `Docker.app`

### Start the Web Server

5.  Navigate to your preferred MySQL Server Version directory by using `cd [GITHUB-REPO-DIR]/macos/Docker/dockerFiles/mysql-[SQLVER]` with `[SQLVER]` being either 5.6, 5.7, or 5.8 for the MySQL Server Version. If you are not planning to run MySQL, you can go to any of the three version directories.

6.  Now, go into the folder of your PHP version of choice by using `cd [GITHUB-REPO-DIR]/macos/Docker/dockerFiles/mysql-[SQLVER]/php-latest-[PHPVER]` with `[PHPVER]` being 7.2, 7.3, 7.4, or 8.0. This corresponds to the latest patch of your PHP version of choice. If you are only planning to run the MySQL Server, you can go into any PHP version directory.

7.  To run the server(s), you can execute `startLAMP.sh` for the LAMP stack, `startMySQL.sh` for just MySQL, or `startPHP.sh` for just PHP/Apache. All of the scripts will asks you for the folder location that it should use to store the files for your website and/or MySQL server, and then download the appropriate Docker Images for the server of choice. This folder location will need to already exist and needs to have proper read/write access by the terminal user of the current session. The download of the Docker Images is all automated (as is everything else).

    -   Accessing MySQL through PDO:

        1.  I would recommend a database connection file (I'll call it _dbconn.php_)
        2.  Information on how to setup the file can be found [here](https://phpdelusions.net/pdo). The one thing to remember is that you will need to replace host with the IP address of the Docker Container of MySQL.
        3.  To get the IP address of the MySQL container, just execute `docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql<SQLVERID>`  with `<SQLVERID>` being _80_  for MySQL 8.0, etc. inside of a terminal while the container is running

8.  To stop the Docker Application, open a terminal and type `docker container stop [php<PHPVERID>] [mysql<SQLVERID>]` with `<PHPVERID>` being _74_ for php 7.4, etc. if you started a Web Server, and `<SQLVERID>` being _80_ for MySQL 8.0, etc. if you started a MySQL Server

## B. Windows 10 (Build 1803+)

1.  Navigate to the location of the Docker Desktop binary archives at `windows/dockerDesktop/`. 

2.  Open the text file that contains the password for the archives and copy it.

3.  Go back to the aforementioned folder above and double click, or execute, `dockerDesktopInstaller_.exe`.

4.  When prompted, paste the password that you just copied into the text field and click OK. The archive should now start extracting.

5.  After the archive has been fully extracted, execute the output file by double-clicking on it. The installation should now begin.

6.  When prompted, restart your computer

7.  After the computer restart and Docker starts, it will prompt you to install the WSL2 linux kernel. Install it and restart docker when prompted.

8.  When docker has restarted, docker should be installed and available for use.

9.  Now that docker is installed, open PowerShell (**_NOT_** Command Prompt)

10. Navigate to `[GITHUB-REPO-DIR]/windows/dockerFiles/`

11. Once there, you can simply type `docker compose up`. This will make sure that PHP, all of its extensions, Apache, and MySQL are all installed properly. If you so choose, you can close the application using _CTRL_ + _C_ in the Terminal where the application is open. After the initial install, you can use `docker compose up -d`. This will run the application detached, meaning it will run in the background. You can stop the container

12. All of your files used for a website will be stored under `[GITHUB-REPO-DIR]/windows/dockerFiles/php/`. You can make a simple _index.php_ file and whatever code you put in there will get processed by Apache. If you have an _index.php_ or _index.html_ file, you can access the website by typing `localhost` into your browser. Any other file name can be accessed from the browser by typing `localhost/[fileName.extension]` where `[filePrefix.extension]` is the full file name including the extension.

    -   Accessing MySQL through PDO:

        1.  I would recommend a database connection file (I'll call it _dbconn.php_)
        2.  Information on how to setup the file can be found [here](https://phpdelusions.net/pdo). The one thing to remember is that you will need to replace host with the IP address of the Docker Container of MySQL.
        3.  To get the IP address of the MySQL container, just execute `docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql8` inside of PowerShell while the container is running.

13. To stop the Docker Application, go to the directory that your Docker Application resides in, and then type `docker compose stop`.

    ## C. Debian-Based Linux Distributions (_Ubuntu_, _Debian_, _Pop!\_OS_, etc.)

    ## To install Docker

    1.  Navigate to `[GITHUB-REPO-DIR]/debian/Docker/dockerd` with `[GITHUB-REPO-DIR]` being the directory of the repository (`cd [GITHUB-REPO-DIR]/debian/Docker/dockerd`)

    2.  execute the install script `installDocker.sh` (`./installDocker.sh`). Enter your password when prompted, and wait for it to finish. This will install Docker and all dependencies

    ## To Install and Run your Web Server

    3.  Choose your Web Server Software. You have a choice to run a full LAMP stack, only MySQL, or only PHP. You can choose between PHP 7.2, 7.3, 7.4, or 8.0-betaX and MySQL 5.6, 5.7, and 8.0

    ### Start Docker

    4.  Navigate to `[GITHUB-REPO-DIR]debian/Docker/dockerd` with `[GITHUB-REPO-DIR]` being the directory of the repository (`cd [GITHUB-REPO-DIR]/debian/Docker/dockerd`)

    5.  Execute `startDocker.sh` (`./startDocker.sh`) to start Docker and then press _CTRL_ + _C_ to break out of the window. _DON'T WORRY_. Docker will continue to run in the background.

    ### Start the Web Server

    6.  Navigate to your preferred MySQL Server Version directory by using `cd [GITHUB-REPO-DIR]/debian/Docker/dockerFiles/mysql-[SQLVER]` with `[SQLVER]` being either 5.6, 5.7, or 5.8 for the MySQL Server Version. If you are not planning to run MySQL, you can go to any of the three version directories.

    7.  Now, go into the folder of your PHP version of choice by using `cd [GITHUB-REPO-DIR]/debian/Docker/dockerFiles/mysql-[SQLVER]/php-latest-[PHPVER]` with `[PHPVER]` being 7.2, 7.3, 7.4, or 8.0. This corresponds to the latest patch of your PHP version of choice. If you are only planning to run the MySQL Server, you can go into any PHP version directory.

    8.  To run the server(s), you can execute `startLAMP.sh` for the LAMP stack, `startMySQL.sh` for just MySQL, or `startPHP.sh` for just PHP/Apache. All of the scripts will asks you for the folder location that it should use to store the files for your website and/or MySQL server, and then download the appropriate Docker Images for the server of choice. This folder location will need to already exist and needs to have proper read/write access by the terminal user of the current session. The download of the Docker Images is all automated (as is everything else).

        -   Accessing MySQL through PDO:

            1.  I would recommend a database connection file (I'll call it _dbconn.php_)
            2.  Information on how to setup the file can be found [here](https://phpdelusions.net/pdo). The one thing to remember is that you will need to replace host with the IP address of the Docker Container of MySQL.
            3.  To get the IP address of the MySQL container, just execute `docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql<SQLVERID>`  with `<SQLVERID>` being _80_  for MySQL 8.0, etc. inside of a terminal while the container is running.

    9.  To Stop the Docker Application, open a terminal and type `docker container stop [php<PHPVERID>] [mysql<SQLVERID>]` with `<PHPVERID>` being _74_ for php 7.4, etc. if you started a Web Server, and `<SQLVERID>` being _80_ for MySQL 8.0, etc. if you started a MySQL Server.

    ## D. RHEL and CentOS

    ## To install Docker

    1.  Navigate to `[GITHUB-REPO-DIR]/RHELCentOS/Docker/dockerd` with `[GITHUB-REPO-DIR]` being the directory of the repository (`cd [GITHUB-REPO-DIR]/RHELCentOS/Docker/dockerd`)

    2.  execute the install script `installDocker.sh` (`./installDocker.sh`). Enter your password when prompted, and wait for it to finish. This will install Docker and all dependencies

    ## To Install and Run your Web Server

    3.  Choose your Web Server Software. You have a choice to run a full LAMP stack, only MySQL, or only PHP. You can choose between PHP 7.2, 7.3, 7.4, or 8.0-betaX and MySQL 5.6, 5.7, and 8.0

    ### Start Docker

    4.  Navigate to `[GITHUB-REPO-DIR]RHELCentOS/Docker/dockerd` with `[GITHUB-REPO-DIR]` being the directory of the repository (`cd [GITHUB-REPO-DIR]/RHELCentOS/Docker/dockerd`)

    5.  Execute `startDocker.sh` (`./startDocker.sh`) to start Docker and then press _CTRL_ + _C_ to break out of the window. _DON'T WORRY_. Docker will continue to run in the background.

    ### Start the Web Server

    6.  Navigate to your preferred MySQL Server Version directory by using `cd [GITHUB-REPO-DIR]/RHELCentOS/Docker/dockerFiles/mysql-[SQLVER]` with `[SQLVER]` being either 5.6, 5.7, or 5.8 for the MySQL Server Version. If you are not planning to run MySQL, you can go to any of the three version directories.

    7.  Now, go into the folder of your PHP version of choice by using `cd [GITHUB-REPO-DIR]/RHELCentOS/Docker/dockerFiles/mysql-[SQLVER]/php-latest-[PHPVER]` with `[PHPVER]` being 7.2, 7.3, 7.4, or 8.0. This corresponds to the latest patch of your PHP version of choice. If you are only planning to run the MySQL Server, you can go into any PHP version directory.

    8.  To run the server(s), you can execute `startLAMP.sh` for the LAMP stack, `startMySQL.sh` for just MySQL, or `startPHP.sh` for just PHP/Apache. All of the scripts will asks you for the folder location that it should use to store the files for your website and/or MySQL server, and then download the appropriate Docker Images for the server of choice. This folder location will need to already exist and needs to have proper read/write access by the terminal user of the current session. The download of the Docker Images is all automated (as is everything else).

        -   Accessing MySQL through PDO:

            1.  I would recommend a database connection file (I'll call it _dbconn.php_)
            2.  Information on how to setup the file can be found [here](https://phpdelusions.net/pdo). The one thing to remember is that you will need to replace host with the IP address of the Docker Container of MySQL.
            3.  To get the IP address of the MySQL container, just execute `docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql<SQLVERID>`  with `<SQLVERID>` being _80_  for MySQL 8.0, etc. inside of a terminal while the container is running.

    9.  To Stop the Docker Application, open a terminal and type `docker container stop [php<PHPVERID>] [mysql<SQLVERID>]` with `<PHPVERID>` being _74_ for php 7.4, etc. if you started a Web Server, and `<SQLVERID>` being _80_ for MySQL 8.0, etc. if you started a MySQL Server.

## PLEASE NOTE

* * *

### 1. Some PHP extensions may not be installed in all versions of the PHP CLI due to incompatibility or build errors. The PHP extensions that were removed from PHP 8 downwards are the following

-   latest-7.4: **_enchant_**
-   latest-7.3: **_enchant, iconv, TIDY_**
-   latest-7.2: **_enchant, iconv, TIDY, GD, webp support, jpeg support, freetype, zip read/write support_**
-   latest-7.1: **_enchant, iconv, TIDY, Argon2 Password Hashing, GD, webp support, jpeg support, freetype, sodium, zip read/write support_**

### 2. Due to the increased complexity and massively increased user input required to the point where you might as well compile it yourself on Windows, support for this operating system has been temporarily (and possibly permanently) limited to only the Docker Application in this project's roadmap until further notice

### 3. If you find any issues or ommisions, please open up an issue on GitHub

* * *

#### Psst...Disclaimer

* * *

This product includes PHP software, freely available from <http://www.php.net/software/>
