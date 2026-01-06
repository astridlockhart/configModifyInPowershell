  #in line parameters format: configModify.ps1 <config file> <configuration> <new setting>
param(
    [Parameter()]
    [string]$sourceFile = "Heya!", #the config file we want to modify.

    [Parameter()]
    [string]$configEdit = "Heya!", #the configuration we want to edit.
    
    [Parameter()]
    [string]$modifacation = "default" # what we want the new config to be.
    )

#The purpose of this script it to seek out a point in the config file such as "color:" and change it to what is stored in the $modifaction parameter.
foreach($line in Get-Content $sourceFile) { #iterates through txt file.
    if($line -match $configEdit){ #checks for matching text in current line
        
        $editFile = Get-Content $sourceFile #sets config file for editing
        $editFile.Replace($line, "$configEdit $modifacation") | Set-Content -Path $sourceFile # Edits the line!        
    }
}

Write-Host "-------------[New Config File]-----------------------"
cat $sourceFile #confirms new config