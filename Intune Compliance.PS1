$Defender = Get-MpComputerStatus | Select-Object AMServiceEnabled,AMServiceVersion, AntivirusSignatureAge


#===================== Defender Enable Status =============================================

$DefenderStatus = $Defender.AMServiceEnabled



#===================== Defender AMServiceVersion =============================================

$DefenderAMVersion = $Defender.AMServiceVersion



#===================== Defender AntivirusSignatureAge =============================================

$DefenderSigAge = $Defender.AntivirusSignatureAge



#===================== Operating System Version ======================================

$OSVerion = (Get-ComputerInfo | select OsHardwareAbstractionLayer).OsHardwareAbstractionLayer

#===================  To get Windows Defender Firewall Services =======================

$DefService = (Get-Service -Name BITS -ErrorAction SilentlyContinue).Status
    if($DefService -eq "Running") {$DefServices = "$true"}
        else
      {$DefServices = "$false"}


#===================  To get Windows Defender Firewall Services =======================

$BitStatus = (Get-BitLockerVolume | Select-Object VolumeStatus).Volumestatus
if ($BitStatus -eq 'FullyEncrypted' ) {$BitStatuss = $true}
else
{$BitStatuss = $false}


$has = @{ DefenderStatus = $DefenderStatus; DefenderVersion = $DefenderAMVersion; SigStatus = $DefenderSigAge; OSVersion =$OSVerion ;DefenderServiceStatus = $DefServices; BitlockerStatus = $BitStatuss}
return $has | ConvertTo-Json -Compress