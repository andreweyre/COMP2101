function Get-PCID {                                                       #Create function Get-PCID
  get-wmiobject -class win32_computersystem |                             #Get the computersystem objects
    select Manufacturer, Model, Caption,PrimaryOwnerName, SystemType |    #Pipe them to select Manufacturer, Model, Caption,PrimaryOwnerName, SystemType Objects
  Format-List Manufacturer, Model, Caption, PrimaryOwnerName, SystemType  #Pipe to format output in specified order as a list to print
}                                                                         #end of function Get-PCID

function Get-BIOS {                                                       #Create function Get-Bios
  get-wmiobject -class win32_bios |                                       #Get the bios objects
    select Manufacturer, Description, Version, SMBBIOSBIOSVersion |       #Pipe them to select Manufacturer, Description, Version, SMBBIOSBIOSVersion objects
  Format-List Manufacturer, Description, Version, SMBBIOSBIOSVersion      #Pipe to format output in specified order as a list to print
}                                                                         #end of function Get-Bios

function Get-Processor {                                                  #Create function Get-processor
  get-wmiobject -class win32_processor |                                  #Get the processor objects
    select Manufacturer, Name, NumberOfCores, MaxClockSpeed |             #Pipe them to select Manufacturer, Name, NumberOfCores, MaxClockSpeed objects
  Format-List Manufacturer, Name, NumberOfCores, MaxClockSpeed            #Pipe to format output in specified order as a list to print
}                                                                         #end of function Get-Processor


function Get-Memory {                                                     #Create function Get-Memory
  $totalcapacity = 0                                                      #Start with total RAM capacity of zero
  get-wmiobject -class win32_physicalmemory |                             #Get the physical memory objects 
    foreach {                                                             #Pipe them to foreach to create new objects
      new-object -TypeName psobject -Property @{                          #Make a new object for each incoming memory object
	    Manufacturer = $_.manufacturer                                    #Create Manufacturer object
	    "Size(MB)" = $_.capacity/1mb                                      #Create Size object of RAM in MB
	    "Speed(MHz)" = $_.speed                                           #Create Speed object of RAM in MHz
	    Bank = $_.banklabel                                               #Create Bank object for which bank RAM is in 
        Slot = $_.devicelocator                                           #Create Slot object where RAM is located
      }                                                                   #end of new object creation with custom properties above
      $totalcapacity += $_.capacity/1mb                                   #Add the current memory device object capacity to running total
    } | ft -auto Manufacturer, "Size(MB)", "Speed(MHz)", Bank, Slot       #Pipe custom objects to format-table to print

  "Total RAM: ${totalcapacity}MB "                                                                 #Display Total capacity obtained from adding all memory capacities up
  $visablememory = (get-wmiobject win32_operatingsystem).totalvisiblememorysize / 1kb -as [int]    #get totalvisiblememory from operatingsystem objects divide by kb and format as an integer
  $freememory = (get-wmiobject win32_operatingsystem).freephysicalmemory /1kb -as [int]            #get freephysicalmemory from operatingsystem objects divide by kb and format as an integer
  "Usable Memory: ${visablememory}MB"                                                              #Display Usable Memory obtained from totalvisiblememorysize with MB label                                                       
  "Free Memory  : ${freememory}MB"                                                                 #Display Free Memory obtained from freephysicalmemory with MB label  
  ""                                                                                               #Adds spacing
}                                                                                                  #End of function Get-Memory

function Get-Storage {                                              #Create function Get-Storage
  get-wmiobject -class win32_logicaldisk |                          #Get the logical disk objects 
    Where-Object size -gt 0 |                                       #Pipe them to where-object with condition of size greater than zero 
    format-table -AutoSize DeviceID,                                #Pipe objects to format-table to print objects, Column title DeviceID with corresponding value
    @{n="Size(GB)"; e={$_.size/1gb -as [int]}},                     #Column title Size(GB) with corresponding object value from size divided by gb formatted as an integer
    @{n="Free(GB)"; e={$_.freespace/1gb -as [int]}},                #Column title Free(GB) with corresponding object value from freespace divided by gb formatted as an integer
    @{n="% Free"; e={100*$_.freespace/$_.size -as [int]}},          #Column title % Free with corresponding object value from freespace divided by size multiplied by 100 formatted as an integer
    ProviderName                                                    #Column title ProviderName with corresponding value
}                                                                   #End of function Get-Storage

function Get-Network {                                                                             #Create function Get-Network
  Get-WmiObject Win32_NetworkAdapter |                                                             #Get Network Adapter objects
    Where-Object {$_.NetConnectionID -Match "Ethernet" -or $_.NetConnectionID -Match "Wi-Fi"} |    #Pipe them to where-object and filter objects on NetConnectionID to show only Ethernet or Wi-Fi
      Foreach-Object{                                                                              #Pipe them to foreach to create new objects

      $nac = @($_.GetRelated('Win32_NetworkAdapterConfiguration'))[0]        #For the networkadapters filtered above get related items from NetworkAdapter Configuration objects

      New-Object PSObject -Property @{                                       #Make a new object for each incoming network adapter object
        Name = $_.Name                                                       #Create Name object with corresponding value
        MAC = $_.MACAddress                                                  #Create MAC object with corresponding value
        "Speed(MB/s)" = $_.speed / 1000000                                   #Create Speed(MB/s) object with speed value divided by 1000000
        "IPV4 Addr" = $nac.IPAddress | where-object {$_ -notmatch ":"}       #Create IPV4 Addr object from networkadapterconfiguration ipaddress object where object does not include :
        "IPV4 Netmask" = $nac.IPSubnet | where-object {$_ -like "*.*.*.*"}   #Create IPV4 Netmask object from networkadapterconfiguration ipsubnet object where object pattern is like *.*.*.*
        Gateway = $nac.DefaultIPGateway | where-object {$_ -notmatch ":"}    #Create Gateway object from networkadapterconfiguration DefaultIPGateway object where object does not include :
        "DNS Domain" = $nac.DNSDomain                                        #Create DNS Domain object with corresponding value from networkadapterconfiguration
        Hostname = $nac.DNSHostName                                          #Create Hostname object with corresponding value from networkadapterconfiguration
      }                                                                      #end of new object creation with custom properties above
    } | Format-List Name, MAC, "Speed(MB/s)", "IPV4 Addr", "IPV4 Netmask", Gateway, "DNS Domain", Hostname    #Pipe to format output in specified order as a list to print
}                                                                                                             #End of function Get-Network

function Get-Graphics {                                                               #Create function Get-Graphics
  get-wmiobject -class win32_videocontroller |                                        #Get the videocontroller objects
    foreach {                                                                         #Pipe them to foreach to create new objects
      new-object -TypeName psobject -Property @{                                      #Make a new object for each incoming graphics object
	  Name = $_.Name                                                                  #Create Name object with corresponding value
	  VRAM = $_.AdapterRAM/1gb -as [int] | foreach-object {$_.tostring() + 'GB'}      #Create VRAM object from adapterRAM divide by gb and format as an integer, convert to string for each and add GB
	  Resolution = $_.videomodedescription                                            #Create resolution object
    }                                                                                 #end of new object creation with custom properties above
  } | Format-List Name, VRAM, Resolution                                              #Pipe to format output in specified order as a list to print
}                                                                                     #end of function Get-Get-Graphics

function Get-OS {                                                                     #Create function Get-OS
  get-wmiobject win32_operatingsystem |                                               #Get the operatingsystem objects
    select Manufacturer, Caption, Version, OSArchitecture, RegisteredUser |           #Pipe them to select Manufacturer, Caption, Version, OSArchitecture, RegisteredUser objects
  Format-List Manufacturer, Caption, Version, OSArchitecture, RegisteredUser          #Pipe to format output in specified order as a list to print
}                                                                                     #end of function Get-OS

#REPORT STYLE PRODUCTION
#Create titles with string creation
#Data for each title is pulled by using the functions created above

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

Pause