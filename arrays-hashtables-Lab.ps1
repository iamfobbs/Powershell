##LAB###

#create an empty array
$a=@()
$a=9..19
$a

#display the fourth element of the array
$a[4]

#create a hash table with my details
$h=@{Name="Dennis Ofoborh";Computername=$env:COMPUTERNAME;Date=(get-date)}
$h
$h=[ordered]@{Name="Dennis Ofoborh";Computername=$env:COMPUTERNAME;Date=(get-date)}
$h


#add to key to the previous hash table called random
$h.Add("Random",(get-random))
$h

help about_hash
