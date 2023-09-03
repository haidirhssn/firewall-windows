# Run this script from your powershell session to temporary bypass some policy
# PowerShell -ExecutionPolicy Bypass







# These are different ways to output a text
<#
Write-Host 'Hello, World!'
'Hello, World2!' | Write-Host
Write-Output 'Hello, World! Write-Output'
'Hello, World!2 Write-Output' | Write-Output
#>


# This is a variable
<#
$varName = Read-Host 'Enter your name'
$password = Read-Host 'Enter your password' -AsSecureString
Write-Host $varName
Write-Host $password
#>


# $folderPath = Read-Host 'Enter the folder path'
$folderPath = 'C:\Users\HDS\AppData\SomeFolder'
Write-Host $folderPath

$allExeFiles = Get-ChildItem -Path $folderPath -Recurse -Force -Include *.exe
# Write-Host $child
# Write-Host $child.Length
    $count = 0

foreach ($exeFile in $allExeFiles) {
    $firewallRule = Get-NetFirewallRule -DisplayName $exeFile -ErrorAction SilentlyContinue
    # try {
    #     $firewallRule = Get-NetFirewallRule -DisplayName $exeFile -ErrorAction Stop
    # }
    # catch [System.Exception] {
    #     Write-Host "An error occured"
    # }
    if (($firewallRule.DisplayName -eq $exeFile) -and ($firewallRule.Direction -eq "Outbound")) {
        Write-Host "Firewall rule outbound already exist for: $(${firewallRule}.DisplayName)"
        $count = $count + 1
        # Write-Host $firewallRule.DisplayName
    } elseif (($firewallRule.DisplayName -eq $exeFile) -and ($firewallRule.Direction -eq "Inbound")) {
        Write-Host "Firewall rule outbound already exist for: $(${firewallRule}.DisplayName)"
        $count = $count + 1
    } else {
        #New-NetFirewallRule -DisplayName $exeFile -Direction Outbound -Program $exeFile -Action Block
        #New-NetFirewallRule -DisplayName $exeFile -Direction Inbound -Program $exeFile -Action Block
    }
    Write-Host $count
    # Write-Host $exeFile
    # # New-NetFirewallRule -DisplayName $exeFile -Direction Outbound -Program $exeFile -Action Block
    # if (Get-NetFirewallRule -DisplayName $exeFile -Direction Outbound | Get-NetFirewallRule -DisplayName) {
    #     Write-Host "The firewall exits"
    # }
    # else {
    #     Write-Host "The firewall doesn't exist"
    # }
}

# Write-Host $variablefromforeach
# Get-NetFirewallRule -DisplayName "BlockAdobe"
# Get-NetFirewallRule -DisplayName "C:\Users\HDS\AppData\Roaming\CareUEyes\update.exe"

# New-NetFirewallRule -DisplayName 'C:\Users\HDS\AppData\Roaming\CareUEyes\update.exe' -Direction Outbound -Program 'C:\Users\HDS\AppData\Roaming\CareUEyes\update.exe' -Action Block

# $allRules = Get-NetFirewallRule -Action Block
# foreach ($f in $allRules) {
#     Write-Host $f.DisplayName
#     Write-Host $f.Direction
# }
# Write-Host $allRules

# Method to read a input
Read-Host
