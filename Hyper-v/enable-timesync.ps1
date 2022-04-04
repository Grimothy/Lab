#enable
$vms=Get-VM | Out-GridView -Title "select vms to enable service" -PassThru
foreach ($vm in $vms) { Enable-VMIntegrationService -VMName $vm.VMName -Name "Time Synchronization" -Verbose}

Start-Sleep -Seconds 5 -Verbose

#disable
#$vms=Get-VM | Out-GridView -Title "select vms to disable service" -PassThru
foreach ($vm in $vms) { disable-VMIntegrationService -VMName $vm.VMName -Name "Time Synchronization" -Verbose}