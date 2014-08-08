#Demo Array


$a = 1..10
$a
#how many
$a.count
#access by index number 

$a[0]
$a[1..3]
#last item in the array
$a[-1]

#array of objects
$b = Get-Service s*
$b[0]
#in v 2 we would need this to select a single property
$b | select DisplayName


#in version 3 posh
#automatically enumarates the objects for you
$b.DisplayName

#arrays can contain separate list of arrays
$c = 1,'b',3,$PSVersionTable,(Get-Process w*)
$c.Count
$c[3].psversion

#last elements of $c
$c[-1]
$c[-1][0]


#create an empty array
$d=@()

#add to it
$d+=100
$d+=200
$d+=300
$d+=1,3,5,7,9
$d

#cant subject an object from an array
$d-=9
$d-=$d[-1]

#best thing is to filter object you dont want and recreate array
$d = $d | where {$_ -ge 100}
$d


#PRACTICAL
#an array of domaincontrollers
$dcs = "R1L1MGT02CLA","R1L2MGT02CLA"
#array of service names
$services = "wuauserv","winmgmt"

#get-service parameters can accept arrays
Get-Help get-service -Parameter *name #The [] brackets indicates the parameter
#takes an array of strings

#use array as parameter values
Get-service -Name $services -ComputerName $dcs | select name,displayname,status,machinename


#Another example 
$computers= $dcs, "R1L1MGT01CLB","R1L1MGT03CLA"
$computers | where { -not (Test-Connection $_ -Quiet -Count 1)}





