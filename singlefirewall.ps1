$folderPath = Read-Host 'Enter the folder path'
# $folderPath = 'testpath'

$allExeFiles = Get-ChildItem -Path $folderPath -Recurse -Force -Include *.exe

if ($allExeFiles.Length -gt 0) {
    Write-Host "Found $(${allExeFiles}.Length) exe files.`n"
    Write-Host "`nADDING INBOUND AND OUTBOUND FIREWALL...`n"
} else {
    Write-Host "`nNo exe file found at path: $folderPath `nPlease make sure your path is correct!"
}

foreach ($exeFile in $allExeFiles) {
    # get the existing firewall with Outbound/Inbound rule
    $firewallRuleOut = Get-NetFirewallRule -DisplayName $exeFile -ErrorAction SilentlyContinue | Where-Object Direction -eq 'Outbound'
    $firewallRuleIn = Get-NetFirewallRule -DisplayName $exeFile -ErrorAction SilentlyContinue | Where-Object Direction -eq 'Inbound'

    # check if the firewall rule does not exists yet.
    if ($null -eq $firewallRuleOut) {
        # Write the firewall
        $success = New-NetFirewallRule -DisplayName $exeFile -Direction Outbound -Program $exeFile -Action Block
        Write-Host "$(${success}.DisplayName) Outbound firewall successfully added."
    } else {
        Write-Host "$(${firewallRuleOut}.DisplayName): Outbound firewall already exist!"
    }

    if ($null -eq $firewallRuleIn) {
        # Write the firewall
        $success = New-NetFirewallRule -DisplayName $exeFile -Direction Inbound -Program $exeFile -Action Block
        Write-Host "$(${success}.DisplayName) Inbound firewall successfully added."
    } else {
        Write-Host "$(${firewallRuleIn}.DisplayName): Inbound firewall already exist!"
    }
}

Write-Host "`nDone"
Read-Host "Press Enter key to exit..."