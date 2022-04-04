#Get-VMNetworkAdapter -VMName "pfsense" | Where-Object -Property "Macaddress" -EQ "00155D01F51E" | Set-VMNetworkAdapterVlan -Trunk -AllowedVlanIdList "1-2048" -NativeVlanId 0


$vmlist = Get-VM | Out-GridView -Title "select vm" -PassThru
$switch = Get-VMSwitch | Out-GridView -PassThru
#$switch = "contoso-private"
$niccount = Read-Host -Prompt "number of nics"
$vlanid = Read-Host -Prompt "enter vlan id"
foreach ($vm in $vmlist) { 
    Stop-VM -VMName $vm.Name -TurnOff -Force -Verbose
    1..$niccount| % {Add-VMNetworkAdapter -VMName $vm.VMName -SwitchName $switch.Name -Verbose}
    Set-VMNetworkAdapterVlan -VMName $vm.VMName -Access -VlanId $vlanid -Verbose
    #Start-VM -VMName $vm.Name -Verbose
}

$vmlist = Get-VM | Out-GridView -Title "select vm" -PassThru
#$switch = Get-VMSwitch | Out-GridView -PassThru
#$niccount = Read-Host -Prompt "number of nics"
#$vlanid = Read-Host -Prompt "enter vlan id"
foreach ($vm in $vmlist) { 
    Stop-VM -VMName $vm.Name -TurnOff -Force -Verbose
    Remove-VMNetworkAdapter -VMName $vm.Name -Verbose
    #Start-VM -VMName $vm.Name -Verbose
}