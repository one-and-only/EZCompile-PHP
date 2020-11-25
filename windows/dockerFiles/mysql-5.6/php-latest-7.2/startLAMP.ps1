function Show-Form($appType, $appVersion) {
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    $form = New-Object System.Windows.Forms.Form
    if ($appType -eq "MySQL") {
        $form.Text = 'Start MySQL ' + $appVersion
    }
    elseif ($appType -eq "PHP") {
        $form.Text = 'Start PHP ' + $appVersion
    }
    $form.Size = New-Object System.Drawing.Size(600,200)
    $form.StartPosition = 'CenterScreen'

    $okButton = New-Object System.Windows.Forms.Button
    $okButton.Location = New-Object System.Drawing.Point(200,120)
    $okButton.Size = New-Object System.Drawing.Size(100,23)
    $okButton.Text = 'OK'
    $okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $form.AcceptButton = $okButton
    $form.Controls.Add($okButton)

    $cancelButton = New-Object System.Windows.Forms.Button
    $cancelButton.Location = New-Object System.Drawing.Point(300,120)
    $cancelButton.Size = New-Object System.Drawing.Size(100,23)
    $cancelButton.Text = 'Exit'
    $cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
    $form.CancelButton = $cancelButton
    $form.Controls.Add($cancelButton)

    $label = New-Object System.Windows.Forms.Label
    $label.Location = New-Object System.Drawing.Point(20,20)
    $label.Size = New-Object System.Drawing.Size(550,30)
    if ($appType -eq 'MySQL') {
        $label.Text = 'Where would you like your MySQL server files to reside on your local machine (absolute path, must exist)?'
    }
    elseif ($appType -eq 'PHP') {
        $label.Text = 'Where would you like your PHP website files to reside on your local machine (absolute path, must exist)?'
    }
    $form.Controls.Add($label)

    $textBox = New-Object System.Windows.Forms.TextBox
    $textBox.Location = New-Object System.Drawing.Point(50,60)
    $textBox.Size = New-Object System.Drawing.Size(475,20)
    $form.Controls.Add($textBox)

    $form.Topmost = $true

    $form.Add_Shown({$textBox.Select()})
    $result = $form.ShowDialog()

    if ($result -eq [System.Windows.Forms.DialogResult]::OK)
    {
        if ($appType -eq "PHP") {
            return $textBox.Text
        }
        elseif ($appType -eq "MySQL") {
            return $textBox.Text
        }
    }
    elseif ($result -eq [System.Windows.Forms.DialogResult]::Cancel) {
        Exit
    }
}

function SQLSetup {
    $MYSQLFOLDERLOCATION = Show-Form -appType "MySQL" -appVersion "5.6"
    $ISMYSQLFOLDERPRESENT = Test-Path $MYSQLFOLDERLOCATION -PathType Container
    if ($MYSQLFOLDERLOCATION -eq "") {
        Write-Output "The path of the MySQL file folder cannot be empty. Please choose a folder."
        SQLSetup
    }
    elseif (!$ISMYSQLFOLDERPRESENT) {
        Write-Output "$MYSQLFOLDERLOCATION does not exist, please choose another folder."
        SQLSetup
    }
}
function PHPSetup {
    $APACHEFOLDERLOCATION = Show-Form -appType "PHP" -appVersion "7.2"
    $ISAPACHEFOLDERPRESENT = Test-Path $APACHEFOLDERLOCATION -PathType Container
    if ($APACHEFOLDERLOCATION -eq "") {
        Write-Output "The path of the PHP website files folder cannot be empty. Please choose a folder."
        PHPSetup
    }
    elseif (!$ISAPACHEFOLDERPRESENT) {
        Write-Output "$APACHEFOLDERLOCATION does not exist, please choose another folder." 
        PHPSetup
    }
}

SQLSetup
PHPSetup

Write-Progress -Activity "Setting Up PHP 7.2 and MySQL 5.6" -Status "0% Complete:" -PercentComplete 0;
if ($null -eq (docker ps -q -f name=php72)) {
    if (!$null -eq (docker ps -aq -f status=exited -f name=php72) -or !$null -eq (docker ps -aq -f status=created -f name=php72 -eq $null)) {
        # cleanup
        Write-Progress -Activity "Setting Up PHP 7.2 and MySQL 5.6" -Status "25% Complete:" -PercentComplete 25 -CurrentOperation "Removing PHP 7.2 Container";
        docker Remove-Item php72
    }
    # run your container
    Write-Progress -Activity "Setting Up PHP 7.2 and MySQL 5.6" -Status "50% Complete:" -PercentComplete 50 -CurrentOperation "Starting PHP 7.2 Container";
    if (docker run -d -p 80:80 -p 443:443 --volume ${APACHEFOLDERLOCATION}:/var/www/html/ --name php72 frostedflakez/php-mysql-webserver:php-latest-7.2) {
        $phpstatus = "started"
    }
    else {
        $phpstatus = "error"
    }
}
# container is already running
elseif (!$null -eq (docker ps -aq -f status=running -f name=php72)) {
    Write-Progress -Activity "Setting Up PHP 7.2 and MySQL 5.6" -Status "50% Complete:" -PercentComplete 50 -CurrentOperation "Starting PHP 7.2 Container";
    $phpstatus = "already-running"
}

if ($null -eq (docker ps -q -f name=mysql56)) {
    if (!$null -eq (docker ps -aq -f status=exited -f name=mysql56) -or !$null -eq (docker ps -aq -f status=created -f name=mysql56 -eq $null)) {
        # cleanup
        Write-Progress -Activity "Setting Up PHP 7.2 and MySQL 5.6" -Status "75% Complete:" -PercentComplete 75 -CurrentOperation "Removing MySQL 5.6 Container";
        docker Remove-Item mysql56
    }
    # run your container
    if (docker run -d -p 3306:3306 -p 33060:33060 --volume ${MYSQLFOLDERLOCATION}:/var/lib/mysql --name mysql56 frostedflakez/php-mysql-webserver:mysql-latest-5.6) {
        Write-Progress -Activity "Setting Up PHP 7.2 and MySQL 5.6" -Status "99% Complete:" -PercentComplete 99 -CurrentOperation "Starting MySQL 5.6 Container";
        $mysqlstatus = "started"
    }
    else {
        $mysqlstatus = "error"
    }
}
# container is already running
elseif (!$null -eq (docker ps -aq -f status=running -f name=mysql56)) {
    Write-Progress -Activity "Setting Up PHP 7.2 and MySQL 5.6" -Status "99% Complete:" -PercentComplete 99 -CurrentOperation "Starting MySQL 5.6 Container";
    $mysqlstatus = "already-running"
}

#show MySQL container status message
if ($mysqlstatus -eq "started") {
    Write-Output "MySQL 5.6 Successfully Started"
}
elseif ($mysqlstatus -eq "already-running") {
    Write-Output "MySQL 5.6 is Already Running"
}
elseif ($mysqlstatus -eq "error") {
    Write-Output "There Was an Error Starting MySQL 5.6"
}

# show PHP container status message
if ($phpstatus -eq "started") {
    Write-Output "PHP 7.2 Successfully Started"
}
elseif ($phpstatus -eq "already-running") {
    Write-Output "PHP 7.2 is Already Running"
}
elseif ($phpstatus -eq "error") {
    Write-Output "There Was an Error Starting PHP 7.2"
}
