Get-Service 

#to know properties can be looked into using gm
Get-Service | Get-Member

#what are the property types
Get-Service | gm -MemberType properties

#and once you know that you can call it
Get-Service | select name, status, servicetype | ft -a

#start time only works locally
#finds out the latest running process/program.
notepad;calc;chrome
Get-process | where starttime | select id, name, starttime, 
@{name="runtime";Expression={(Get-Date) - $_.starttime}} | sort runtime

#Example Of A Drive Report
$computers = "R1L1WEB01CLA","R1L1WEB02CLA","R1L2WEB02CLA"
Get-CimInstance win32_logicaldisk -Filter "drivetype= 3" -Comp $computers | 
ft -GroupBy pscomputername -property deviceid, volumename, 
@{N="SizeGB";E={[math]::Round($_.Size/1GB)}},
@{N="FreeGB";E={[math]::Round($_.Freespace/1GB,2)}}, 
@{N="PerFree";E={[math]::Round(($_.Freespace/$_.Size)*100,2)}}



#passthru a single change
dir C:\Work -File -Recurse

$files = dir \\r1l2web02cla\c$\Users\ofoborhd\downloads -file
#view existing members
$files | gm

#add a custom member
#these are aliases we can not filter to get the data we want
$files | Add-Member -MemberType AliasProperty -Name Size -Value Length
$files | Add-Member ScriptProperty -Name FileAge -Value {(Get-Date) - ($this.LastwriteTime)}
$files | Add-Member ScriptProperty -Name FileAgeDays -Value {[int]((Get-Date) - ($this.LastWriteTime)).Total}

$files | sort size -Descending | select fullname, size, creationtime,lastwritetime,fileage* | out-gridview -title "Public Files"


#type accelerators in a powershell object
[psobject].assembly.GetType("System.Management.Automation.TypeAccelerators")::Get



#PRACTICAL EXAMPLE
#USING AN OBJECT
#New object is also [pscustomobject]
#Powershell always you to create hash tables and then turn them to a custom object


Get-EventLog -List

#Active Directory: Checking AD to see services directory & loggging tied to the service.
$computers = "R1L2MGT01CLB"
$dcs = foreach ($computer in $computers) {
    $ntds = dir '\\R1L1MGT01CLB\c$\Windows\NTDS\ntds.dit'
    $OS = Get-WmiObject win32_operatingsystem -ComputerName $computer
    $DSLog = Get-EventLog -logname application -newest 20 -computer $computer
    $Netlogon = Get-WmiObject win32_share -Filter "name='Netlogon'" -ComputerName $computer
    $Sysvol = Get-WmiObject win32_share -Filter "name='SysVol'" -ComputerName $computer

    #create a custom object for each domain controller
    [pscustomobject][ordered]@{
        Computername = $os.CSName
        OperatingSystem = $os.caption
        ServicePack = $os.ServicePackMajorVersion
        NTDS = $NTDS
        DSLog = $DSLog
        Netlogon = $Netlogon.Path
        SysVol = $Sysvol.Path
     }
}

$dcs
$dcs | select -Expandproperty ntds

#or expand like this
#THIS CAN ONLY BE DONE WITH A CUSTOM OBJECT CREATED! Remember that!
$dcs.dslog | where {$_.entrytype -ne 'information'} | select timegenerated, entrytype, source, message,
@{N="ComputerName";E={$_.Machinename}} 



#########################
########## EXERCISE #####################

#Notes
Get-EventLog  - display 100 most recent system event logs
Show Only - 
= TimeGenerated, 
= A property that shows how old an event is
= Source
= display computername instead of Machinename



#EXERCISE
#1
Get-EventLog -list
Get-EventLog application -Newest 10 | select max | gm

#2

#3

#Version 1
Get-EventLog system -Newest 100 | select TimeGenerated,@{N="Event Age";E={$_.TimeWritten}},
@{N="ComputerName";E={$_.MachineName}} | ft -a

#Version 2
Get-EventLog system -Newest 20 | select TimeGenerated,@{N="EventAge";E={[int]((get-date).Date - ($_.TimeWritten)).Day}},
@{N="ComputerName";E={$_.MachineName}} | ft -a