function Get-PCID {
  get-wmiobject -class win32_computersystem | 
    select Manufacturer, Model, Caption,PrimaryOwnerName, SystemType |
  Format-List Manufacturer, Model, Caption, PrimaryOwnerName, SystemType
}

function Get-BIOS {
  get-wmiobject -class win32_bios | 
    select Manufacturer, Description, Version, SMBBIOSBIOSVersion |
  Format-List Manufacturer, Description, Version, SMBBIOSBIOSVersion
}

function Get-Processor {
  get-wmiobject -class win32_processor | 
    select Manufacturer, Name, NumberOfCores, MaxClockSpeed |
  Format-List Manufacturer, Name, NumberOfCores, MaxClockSpeed
}

function Get-Memory {
  $totalcapacity = 0
  get-wmiobject -class win32_physicalmemory | 
    foreach {
      new-object -TypeName psobject -Property @{
	    Manufacturer = $_.manufacturer
	    "Size(MB)" = $_.capacity/1mb                        
	    "Speed(MHz)" = $_.speed
	    Bank = $_.banklabel
        Slot = $_.devicelocator
      }
      $totalcapacity += $_.capacity/1mb
    } | ft -auto Manufacturer, "Size(MB)", "Speed(MHz)", Bank, Slot

  "Total RAM: ${totalcapacity}MB "
  $visablememory = (get-wmiobject win32_operatingsystem).totalvisiblememorysize / 1kb -as [int]
  $freememory = (get-wmiobject win32_operatingsystem).freephysicalmemory /1kb -as [int]
  "Usable Memory: ${visablememory}MB"
  "Free Memory  : ${freememory}MB"
  ""
}

function Get-Storage {
  get-wmiobject -class win32_logicaldisk |
    Where-Object size -gt 0 |
    format-table -AutoSize DeviceID,
    @{n="Size(GB)"; e={$_.size/1gb -as [int]}},
    @{n="Free(GB)"; e={$_.freespace/1gb -as [int]}},
    @{n="% Free"; e={100*$_.freespace/$_.size -as [int]}},
    ProviderName
}

function Get-Network {
  Get-WmiObject Win32_NetworkAdapter |
    Where-Object {$_.NetConnectionID -Match "Ethernet" -or $_.NetConnectionID -Match "Wi-Fi"} | Foreach-Object{

    $nac = @($_.GetRelated('Win32_NetworkAdapterConfiguration'))[0]

      New-Object PSObject -Property @{
        Name = $_.Name
        MAC = $_.MACAddress
        "Speed(MB/s)" = $_.speed / 1000000
        "IPV4 Addr" = $nac.IPAddress | where-object {$_ -notmatch ":"}
        "IPV4 Netmask" = $nac.IPSubnet | where-object {$_ -like "*.*.*.*"}
        Gateway = $nac.DefaultIPGateway | where-object {$_ -notmatch ":"}
        "DNS Domain" = $nac.DNSDomain
        Hostname = $nac.DNSHostName
      }
    } | Format-List Name, MAC, "Speed(MB/s)", "IPV4 Addr", "IPV4 Netmask", Gateway, "DNS Domain", Hostname
}

function Get-Graphics {
  get-wmiobject -class win32_videocontroller |
    foreach {
      new-object -TypeName psobject -Property @{
	  Name = $_.Name
	  VRAM = $_.AdapterRAM/1gb -as [int] | foreach-object {$_.tostring() + 'GB'}
	  Resolution = $_.videomodedescription
    }
  } | Format-List Name, VRAM, Resolution
}

function Get-OS {
  get-wmiobject win32_operatingsystem | 
    select Manufacturer, Caption, Version, OSArchitecture, RegisteredUser |
  Format-List
}

#REPORT STYLE PRODUCTION

"+-------------------+ 
| PC Identification | 
+-------------------+"
Get-PCID
"+---------------------+ 
| BIOS Identification | 
+---------------------+" 
Get-BIOS
"+--------------------------+ 
| Processor Identification | 
+--------------------------+" 
Get-Processor
"+---------------------------------+ 
| Memory Identification and Usage | 
+---------------------------------+" 
Get-Memory
"+---------------+ 
| Storage Usage | 
+---------------+" 
Get-Storage
"+------------------------------------------+ 
| Network Identification and Configuration | 
+------------------------------------------+" 
Get-Network
"+---------------+ 
| Graphics Info |
+---------------+" 
Get-Graphics
"+-----------------------+
| Operating System Info | 
+-----------------------+" 
Get-OS
