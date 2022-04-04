$vm = get-vm | Out-GridView -Title "Please select vms for deletion" -PassThru


foreach ($i in $vm) {
    Stop-VM -VMName $i.Name
    $vhdPath = Get-VM $i.Name | Select-Object -ExpandProperty HardDrives
    $PVhdPath = Split-Path -Parent $vhhPath.path
    $Vhds = Get-ChildItem $PVhdPath
    
    foreach ($vhd in $Vhds) {
        Remove-VM $i.Name  -Confirm
        Remove-Item -Path $vhd.FullName -Confirm -Force
        
    }
    
}