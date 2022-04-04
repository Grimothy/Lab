[int]$machines = Read-Host "enter number of machines to create"

1..$machines | % {
$vmname = read-host "enter vm name"
$vmpath = "H:\vms"
$switchname = Get-VMSwitch | Out-GridView -PassThru -Title "Select network for virtual machine"
$proccounts = Read-Host "enter number of CPUS"

New-VM -Name $vmname -MemoryStartupBytes 1024MB -Path $vmpath -SwitchName $switchname.Name -Generation 2
New-VHD -Path "$vmpath\$vmname\Virtual Hard Disks\$vmname.vhdx" -SizeBytes 40GB -Dynamic 

Add-VMHardDiskDrive -VMName $vmname -Path "$vmpath\$vmname\Virtual Hard Disks\$vmname.vhdx"

Set-VM -Name $vmname -LowMemoryMappedIoSpace 512MB -MemoryMaximumBytes 4096MB -SnapshotFileLocation $vmpath\$vmname\Snapshots -AutomaticCheckpointsEnabled $false -ProcessorCount $proccounts -Verbose
}




