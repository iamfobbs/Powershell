CHAPTER 3: Powershell In  a Month Of Lunches.

## PURPOSE OF THIS CHAPTER TO TO HELP UNDERSTAND USING THE HELP SYSTEM


#First Lab Answers:


#1. update-help
#2. convertTo-Html /the mark.
#3. out-file x
#4. 
#5. write-eventlog	
#6.  
#7. Start-Transcript stop-transcript
#8. Get-EventLog Security -Newest 100
#9. get-service
#10 get-process 

#11 get-process | out-file c:\test\test.txt -width 20

#12 get-process | out-file c:\test\test.txt -noclobber

#13 get-alias
#14 gps -cn server1
#15
#16 help arrays


########################################

#Answers:
Running update-help
#1. update help

Find a cmdlet that can convert others output to html
#2. help html | get-command -noun html

Redirecting output to a file
#3. out-file

How many cmdlets are available for woking with processes..
#4. 
Get-Command -Noun process

REFER TO LAB NOTES FROM MORELUNCHES.COM....

#5. help *log	 
#6.  help *alias / Get-Command -Noun alias
#7. help transcript | Start-Transcript stop-transcript 

#8. help Get-EventLog -Parameter Newest
    #the parameter is passed to tell help what we are looking for.

#9. help Get-Service -Parameter computername

#10 help Get-process -Parameter computername

#11 (get-process | out-file c:\test\test.txt -width 20) | help out-file -Parameter width

#12 (get-process | out-file c:\test\test.txt -noclobber) help out-file -full

#13 get-alias
#14 ps –c server1

#15 Get-Command -Noun object
    # How to find out how many "object - replace with your nuoun" that deal with cmdlets

#16 help arrays | help about_arrays 


#Help find breaking changes between POWERSHELL VERSIONS 1 & 2
#17 help "breaking change" | help about*powershell*