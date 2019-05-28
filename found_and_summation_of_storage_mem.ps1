



$strings=Import-Csv -Path 'C:\Users\administrator\desktop\add_srm1.csv'

$found = @()

$vms_prod_vcenter = (Get-VM).name

foreach ($vm in $strings)

{

   $v = Get-VM -Name $vm.vmname

   $v.name

   if ($vms_prod_vcenter -contains $v.name)

   {

   write-host "vm found" $v.name

   $found += $v.name

   }

}

$found


 

$fragments_storage = @()
$fragments_mem = @()



 

foreach ($f in $found)

{

$vm=get-vm -Name $f


 

#$vm|select name,provisionedspacegb
$net_adapter=(get-networkadapter -vm $vm).name
$vm|select name, @{N='network';E={$net_adapter}}


$provisionedspacegb=$vm.ProvisionedSpaceGB

$provround=[math]::Round($provisionedspacegb)

$fragments_storage += $provround
$mem_vm=$vm.memoryGB
$memvround=[math]::Round($mem_vm)
$fragments_mem += $memvround



 

 

}

 
 write-host "sum of storae" -ForegroundColor Magenta
$sum_storage = $fragments_storage -join '+'

Invoke-Expression $sum_storage
write-host "sum of memory" -ForegroundColor Blue

$sum_mem = $fragments_mem -join '+'
Invoke-Expression $sum_mem

