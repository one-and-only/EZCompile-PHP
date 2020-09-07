# EZCompile-PHP
## The Easy way to compile and install PHP on MacOS, Windows, and Linux. Status: pre-release, installs PHP CLI (latest-7.1-latest-master[including 8.0-betaX] Version, MacOS ONLY) and can setup a docker application for PHP-7.4.9, Apache-2.4.38, and MySQL-8.0.21 combined) HEAVY DEVELOPMENT

![GitHub release (latest by date including pre-releases)](https://img.shields.io/github/v/release/one-and-only/EZCompile-PHP?color=yellow&include_prereleases&label=latest)
# How to Install PHP CLI (*macOS and Debian ONLY*):
### macOS:
   1. Open Terminal and navigate to ```[GITHUB-REPO-DIR]/macos/CLI/``` with ```[GITHUB-REPO-DIR]``` being the directory of this repository (```cd [GITHUB-REPO-DIR]/macos/CLI/```).
   1. Execute the install script that is inside the above directory by typing ```./install.sh```. This will install Homebrew if it not already installed, install all dependencies required for compiling the PHP CLI, compile the PHP CLI itself, test the build, and then install it. Do ***NOT*** run it with ```sudo ./install.sh``` even if you will be asked later on about your password. This is because Homebrew can't run as admin.
  
      * You're able to choose the version of PHP you want to install between the latest releases of PHP 7.1, 7.2, 7.3, 7.4, 8.0-betaX, and the latest version of the master PHP branch.
      * You will be prompted to choose a version at the beginning of the program. There are other prompts inside of the program, but those should be really self-explanatory.
   1. After PHP CLI has been successfully installed, you can check that it has applied by executing ```php -v```. This will show you the PHP CLI version along with the build date and other information. The build version and date is what you need to pay attention to make sure it installed correctly. You're done!
### Debian:
   1. Open Terminal and navigate to ```[GITHUB-REPO-DIR]/debian/CLI/``` with ```[GITHUB-REPO-DIR]``` being the directory of this repository (```cd [GITHUB-REPO-DIR]/debian/CLI/```).
   1. Execute the install script that is inside the above directory by typing ```./install.sh```. This will install all dependencies required to compile the PHP CLI using the Advanced Package Tool (APT), compile the PHP CLI itself, test the build, and then install it. If you so wish, you may run with ```sudo ./install.sh``` unlike macOS in order to get asked for your admin password once at the start, so you can leave it unattended longer.
     
      * You're able to choose the version of PHP you want to install between the latest releases of PHP 7.1, 7.2, 7.3, 7.4, 8.0-betaX, and the latest version of the master PHP branch.
      * You will be prompted to choose a version at the beginning of the program. There are other prompts inside of the program, but those should be really self-explanatory.
   1. After PHP CLI has been successfully installed, you can check that it has applied by executing ```php -v```. This will show you the PHP CLI version along with the build date and other information. The build version and date is what you need to pay attention to make sure it installed correctly. You're done!
# Installing the Docker Web Server Application (*All Major OSes*):
   ## A. macOS (10.13+ [High Sierra+]):
   1. To install Docker Desktop by navigating to ```[GITHUB-REPO-DIR]/macos/Docker/dockerDesktop/``` with ```[GITHUB-REPO-DIR]``` being the directory of this repository (```cd [GITHUB-REPO-DIR]/macos/Docker/dockerDesktop/```).
   1. Now, install Docker Desktop by simply executing ```installDockerDesktop.sh```. You may be asked for your admin password depending on your installation environment. 
   1. After installation is complete, you can launch Docker Desktop by doubl-clicking *Docker.app* in the applications folder.
   1. Now that docker is installed, open Terminal
   1. Navigate to ```[GITHUB-REPO-DIR]/macos/Docker/dockerFiles/```
   1. Once there, you can simply type ```docker compose up```. This will make sure that PHP, all of its extensions, Apache, and MySQL are all installed properly. If you so choose, you can close the application using *CTRL* + *C* in the Terminal where the application is open. After the initial install, you can use ```docker compose up -d```. This will run the application detached, meaning it will run in the background. You can stop the container
   1. All of your files used for a website will be stored under ```[GITHUB-REPO-DIR]/macos/Docker/dockerFiles/php/```. You can make a simple *index.php* file and whatever code you put in there will get processed by Apache. If you have an *index.php* or *index.html* file, you can access the website by typing ```localhost``` into your browser. Any other file name can be accessed from the browser by typing ```localhost/[fileName.extension]``` where ```[filePrefix.extension]``` is the full file name including the extension.
    * Accessing MySQL through PDO:
     1. I would recommend a database connection file (I'll call it *dbconn.php*)
     1. Information on how to setup the file can be found [here](https://phpdelusions.net/pdo). The one thing to remember is that you will need to replace host with the IP address of the Docker Container of MySQL.
     1. To get the IP address of the MySQL container, just execute ```docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql8``` inside of Terminal while the container is running.
   1. To Stop the Docker Application, go to the directory that your Docker Application resides in, and then type ```docker compose stop```.
   ## B. Windows 10 (Build 1803+):
   1. Navigate to the location of the Docker Desktop binary archives at ```windows/dockerDesktop/```. 
   1. Open the text file that contains the password for the archives and copy it.
   1. Go back to the aforementioned folder above and double click, or execute, ```dockerDesktopInstaller_.exe```.
   1. When prompted, paste the password that you just copied into the text field and click OK. The archive should now start extracting.
   1. After the archive has been fully extracted, execute the output file by double-clicking on it. The installation should now begin.
   1. When prompted, restart your computer
   1. After the computer restart and Docker starts, it will prompt you to install the WSL2 linux kernel. Install it and restart docker when prompted.
   1. When docker has restarted, docker should be installed and available for use.
   1. Now that docker is installed, open PowerShell (***NOT*** Command Prompt)
   1. Navigate to ```[GITHUB-REPO-DIR]/windows/dockerFiles/```
   1. Once there, you can simply type ```docker compose up```. This will make sure that PHP, all of its extensions, Apache, and MySQL are all installed properly. If you so choose, you can close the application using *CTRL* + *C* in the Terminal where the application is open. After the initial install, you can use ```docker compose up -d```. This will run the application detached, meaning it will run in the background. You can stop the container
   1. All of your files used for a website will be stored under ```[GITHUB-REPO-DIR]/windows/dockerFiles/php/```. You can make a simple *index.php* file and whatever code you put in there will get processed by Apache. If you have an *index.php* or *index.html* file, you can access the website by typing ```localhost``` into your browser. Any other file name can be accessed from the browser by typing ```localhost/[fileName.extension]``` where ```[filePrefix.extension]``` is the full file name including the extension.
    * Accessing MySQL through PDO:
     1. I would recommend a database connection file (I'll call it *dbconn.php*)
     1. Information on how to setup the file can be found [here](https://phpdelusions.net/pdo). The one thing to remember is that you will need to replace host with the IP address of the Docker Container of MySQL.
     1. To get the IP address of the MySQL container, just execute ```docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql8``` inside of PowerShell while the container is running.
   1. To Stop the Docker Application, go to the directory that your Docker Application resides in, and then type ```docker compose stop```.
   1. Done!
   ## C. Debian-Based Linux Distributions (Debian, Ubuntu, Pop_OS!, etc.):
   1. Coming Soon!
# PLEASE NOTE:
### 1. Some PHP extensions may not be installed in all versions of the PHP CLI due to incompatibility or build errors. The PHP extensions that were removed from PHP 8 downwards are the following:
  * latest-7.4: ***enchant***
  * latest-7.3: ***enchant, iconv, TIDY***
  * latest-7.2: ***enchant, iconv, TIDY, GD, webp support, jpeg support, freetype, zip read/write support***
  * latest-7.1: ***enchant, iconv, TIDY, Argon2 Password Hashing, GD, webp support, jpeg support, freetype, sodium, zip read/write support***
  
### 2. Due to the increased complexity and massively increased user input required to the point where you might as well compile it yourself on Windows, support for this operating system has been temporarily (and possibly permanently) limited to only the Docker Application in this project's roadmap until further notice.

### 3. If you find any issues or ommisions, please open up an issue on GitHub.
---
#### Psst...Disclaimer:

This product includes PHP software, freely available from <http://www.php.net/software/>
