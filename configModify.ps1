  #in line parameters format: configModify.ps1 <config file> <configuration> <new setting>
  # v1.1

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
$spacer = " "
#The purpose of this script it to seek out a point in the config file such as "color:" and change it to what is stored in the $modifaction parameter.
foreach($line in Get-Content $sourceFile) { #iterates through txt file.
    if(($line -split ':')[0].trim() -match "^$configEdit$"){ #checks for matching text in current line
        
        $editFile = Get-Content $sourceFile #sets config file for editing
        $editFile.Replace($line.Substring($configEdit.Length + 1), $spacer + $modifacation) | Set-Content -Path $sourceFile # Edits the line!        
    }
}

Write-Host "-------------[New Config File]-----------------------"
cat $sourceFile #confirms new config
