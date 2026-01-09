  #in line parameters format: configModify.ps1 <config file> <configuration> <new setting>
  # v1.2.1

  # Might wanna take a look at this later [ ('a color: green' -split ':')[0].trim() -match '^a color$' ] this will help
  # with potential trimming of a string!
  # TODO: In a production version of this script might wanna make a backup copy of the config file being edited just in case.

param(
    [Parameter()]
    [string]$sourceFile = "default", #the config file we want to modify.

    [Parameter()]
    [string]$configEdit = "default", #the configuration we want to edit.
    
    [Parameter()]
    [string]$modifacation = "default" # what we want the new config to be.
    )

$i = 0 # look up how return codes work! This variable is meant to work as a check for an error message.
#The purpose of this script it to seek out a point in the config file such as "color:" and change it to what is stored in the $modifacation parameter.
foreach($line in Get-Content $sourceFile) { #iterates through txt file.
    if(($line -split ':')[0].trim() -match "^$configEdit$"){ #checks for matching text in current line
        
        $editFile = Get-Content $sourceFile #sets config file for editing
        $editFile.Replace($line.Substring($configEdit.Length + 1), " " + $modifacation) | Set-Content -Path $sourceFile # Edits the line!   
        $i++ # If { i } equals and non zero number then that means this if statement resolved which means there is no reason to excute the error message.
    }
}

if($i -eq 0){ # { i } is checking to see if the above if statement found an entry at all.
        Write-Host "##############################################################"
        Write-Host "In { $sourceFile } the setting { $configEdit } does not exist!" -ForegroundColor Red
        Write-Host "Please check the spelling of the setting!" -ForegroundColor Red
        Write-Host "##############################################################"
    }
else{ # If { i } equals any non zero number then that mean a setting was found and changed.
    Write-Host "##############################################################"
    Write-Host "-----------------Change Applied Successfully!-----------------" -ForegroundColor Green
    Write-Host "##############################################################"
}
Write-Host "-------------[Config File after script execution]-----------------------"
cat $sourceFile #confirms new config
