function Setup-SQL {
    $MYSQLFOLDERLOCATION = Read-Host -Prompt 'Where would you like your MySQL server files to reside on your local machine (absolute path, must exist)? '
    ls "$MYSQLFOLDERLOCATION"
    $ISMYSQLFOLDERPRESENT = Write-Output $?
    clear
    if ($MYSQLFOLDERLOCATION -eq "") {
        Write-Output "The path of the MySQL file folder cannot be empty. Please choose a folder." -ForegroundColor Yellow
        Setup-SQL
    }
    elseif (!$ISMYSQLFOLDERPRESENT) {
        Write-Output "$MYSQLFOLDERLOCATION does not exist, please choose another folder." -ForegroundColor Red
        Setup-SQL
    }
}

Setup-SQL

if (!(docker ps -q -f name=mysql56)) {
    if ((docker ps -aq -f status=exited -f name=mysql56) -or (docker ps -aq -f status=created -f name=mysql56)) {
        # cleanup
        docker rm mysql56
    }
    elseif (docker ps -aq -f status=running -f name=mysql56) {
        $mysqlstatus = "already-running"
    }
    # run your container
    if (docker run -d -p 3306:3306 -p 33060:33060 --volume ${MYSQLFOLDERLOCATION}:/var/lib/mysql --name mysql56 frostedflakez/php-mysql-webserver:mysql-latest-5.6) {
        $mysqlstatus = "started"
    }
    else {
        $mysqlstatus = "error"
    }
}

clear

#show MySQL container status message
if ($mysqlstatus -eq "started") {
    Write-Output "MySQL 5.6 Successfully Started" -ForegroundColor Green
}
elseif ($mysqlstatus -eq "already-running") {
    Write-Output "MySQL 5.6 is Already Running" -ForegroundColor Yellow
}
elseif ($mysqlstatus -eq "error") {
    Write-Output "There Was an Error Starting MySQL 5.6" -ForegroundColor Red
}
