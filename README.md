# Log-File-IP-Sanitizer
Recurses through files in a given directory, and replaces IPv4 Addresses with a pattern of your choosing.  You also have the option to specify a string, such as a domain name, to replace.

#IP Sanitizer by Roberto Seldner
#Syntax: .\IPSanitize.ps1 .\path\
#Use this script to remove IP addresses and a domain from all files within a specified directory and its subdirectories
#Script will create a "Sanitized-Logs" directory ONE LEVEL UP from the input folder.  All output files will be in this folder.  
#Future Change: I will duplicate the input folder, then, rather than redirecting output, I will set-content of the duplicate
#folder.  This is to preserve the directory structure of the input folder.

#NOTE: I used a simple regex to match IP addresses.  It does not validate proper IP formats.
#NOTE: I.E. the script would replace a string such as 999.999.999.999 even though that's obviously not an IP Address.
#NOTE: I felt there was no need to validate for IPs for my use case since all strings matching this format were IPs/Netmasks.

#KNOWN ISSUES: 
# 1. Directory structure is flattened (as noted above).  Consequently, some output files can be overwritten if subdirectories contain same filenames.
# 2. An empty file is created in the output folder for each directory the script recurses through

Script Prompt Preview:

Pattern Options:

A. 192.XXX.123.XXX

B. XXX.168.XXX.123

C. XXX.XXX.XXX.123

D. XXX.XXX.XXX.XXX

Select desired output pattern:
B

Do you wish to remove a domain name or string [Y/N]?
Y

Enter the domain or string you wish to remove:

Private.Domain.Name

Enter the string you wish to replace this with: 

DOMAINREDACTED


