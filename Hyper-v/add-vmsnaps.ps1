$vms=Get-VM | Out-GridView -Title "select vms to create checkpoint" -PassThru
$snapshoptname=Read-Host -Prompt "Please enter name for snapshopt"
foreach ($vm in $vms) { Checkpoint-VM -VM $vm -SnapshotName $snapshoptname -Verbose}


$vms=Get-VM | Out-GridView -Title "select vms to create checkpoint" -PassThru
#$snapshoptname=Read-Host -Prompt "Please enter name for snapshopt"
foreach ($vm in $vms) { Remove-VMCheckpoint -VMSnapshot $snapshoptname }



$vms=Get-VM | Out-GridView -Title "select vms to create checkpoint" -PassThru
$chkPntName=Read-Host -Prompt "Enter vm checkpoint name here"
#$snapshoptname=Read-Host -Prompt "Please enter name for snapshopt"
foreach ($vm in $vms) { 
    Stop-VM -VM $vm.Name -TurnOff -Force -Confirm:$false
    Restore-VMCheckpoint -VMName $vm.VMName -Name $chkPntName -Confirm:$false 
    Start-VM -VM $vm.Name -Confirm:$false
 }
