
help enable-psremoting -ShowWindow

Get-Service winrm

#enable
Enable-PSRemoting

#shows enpoints
Get-PSSessionConfiguration "microsoft powershell"

#look at the features/ settings for winrm
winrm get winrm/config

#opens group policy management and shows settings
gpmc.msc


# Shows with version of powershell version is used.
Test-WSMan R1L2WEB02CLA.
Test-WSMan R1L2WEB01CLA



#IMPORTANT
# Shows what connections are using WSMAN configurations are currently used. 
cd wsman: #goes to directory


cd .\localhost
dir
#show the ports connections are listened out from
dir .\Listener -Recurse | select name, value


#shell settings
#connection used when you connect to another machine
#what is enabled for client authentication
dir .\Client -Recurse #default ports used

#whats services are used
dir .\Service -Recurse

# plugins
dir .\Plugin

#back to C drive
cd c:\


######
#TRUSTED HOSTS
#####
#what is currenylu set
Get-Item WSMan:\localhost\Client\TrustedHosts 

Get-Item

#set trusted host
Set-Item WSMan:\localhost\Client\TrustedHosts -Value "R1L1MGT01CLB.private.bsi.cloud"
Set-Item WSMan:\localhost\Client\TrustedHosts -Value "R1L2MGT01CLB.private.bsi.cloud"

Get-WSManCredSSP
