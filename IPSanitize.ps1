#IP Sanitizer by Roberto Seldner
#Syntax: .\IPSanitize.ps1 .\path\
#Use this script to remove IP addresses and a domain from all files within a specified directory and its subdirectories
#Script will create a "Sanitized-Logs" directory ONE LEVEL UP from the input folder.  All output files will be in this folder.  
#Future Change: I will duplicate the input folder, then, rather than redirecting output, I will set-content of the duplicate
#folder.  This is to preserve the directory structure of the input folder.
#NOTE: I used a simple regex to match IP addresses.  It does not validate proper IP formats.
#NOTE: I.E. the script would replace a string such as 999.999.999.999 even though that's obviously not an IP.
#NOTE: I felt there was no need to validate for IPs for my use case since all strings matching this format were IPs/Netmasks.

If(!$args[0]){Write-Host "Please specify the input directory
Syntax: ./IPSanitize.ps1 .\path\" -b RED -f White
EXIT}

$IPREGEXSIMP= "(\d{1,3}).(\d{1,3}).(\d{1,3})\.(\d{1,3})"
$INDIR=$args[0]
$OUTDIRtemp=Split-Path -Path $INDIR -Parent
$OUTDIR=$OUTDIRtemp+"\Sanitized-Logs\"
MKDIR $OUTDIR
write-host $OUTDIR
$SCRUBLOG=$OUTDIR+"\scrublog.log"
$TIMESTAMP=Get-Date -Format G

#Menu:
Write-Host "================================
Log File IP Scrubber by Roberto Seldner
================================" -f cyan
Write-Host "
Pattern Options:
A. 192.XXX.123.XXX
B. XXX.168.XXX.123
C. XXX.XXX.XXX.123
D. XXX.XXX.XXX.XXX
Select desired output pattern:
" -f Yellow
$IPCHOICE=Read-Host
Write-Host "Do you wish to remove a domain name or string [Y/N]?" -f yellow
$DOMCHOICE=Read-Host
Switch ($DOMCHOICE){
"Y"{
Write-Host "Enter the domain or string you wish to remove:" -f yellow
$DOMSTRING1=Read-Host
Write-Host "Enter the string you wish to replace this with: E.g. DOMAIN.COM" -f yellow
$DOMPATTERN=Read-Host
}
default{
$DOMSTRING1=$null
}
}#end switch
Switch ($IPCHOICE){
"A"{$PATTERN='$1.XXX.$3.XXX'
Write-Host "
Replacing IPs with pattern: 192.XXX.123.XXX"
if($DOMSTRING1){
    rm $SCRUBLOG
    Write-Output "============================" $TIMESTAMP "IP MATCH/REMOVE COUNT" "IP Pattern Used: $PATTERN" "String Used: $DOMPATTERN" "============================">$SCRUBLOG
    Get-childitem $INDIR -recurse |  
    foreach { 
    $IPs = Get-Content $_.FullName
    $COUNT1=$IPs | select-string -pattern $IPREGEXSIMP -AllMatches
    $COUNT2=$IPs | select-string -pattern $DOMSTRING1 -AllMatches
    $OUTFILES1=$OUTDIR+"\scrubbed-"+$_ 
    $IPs -Replace $IPREGEXSIMP, $PATTERN`
         -Replace $DOMSTRING1, $DOMPATTERN  > $OUTFILES1
    Write-Output $_.FULLNAME $COUNT1.Matches.Count $COUNT2.Matches.Count "-----------------------------------------------------" |
    Tee-Object -FilePath $SCRUBLOG -Append
    }#end foreach
}
Else{
    rm $SCRUBLOG
    Write-Output "============================" $TIMESTAMP "IP MATCH/REMOVE COUNT"  "IP Pattern Used: $PATTERN" "No other strings replaced" "============================">$SCRUBLOG
    Get-childitem $INDIR -recurse |  
    foreach { 
    $IPs = Get-Content $_.FullName
    $COUNT1=$IPs | select-string -pattern $IPREGEXSIMP -AllMatches
    $OUTFILES1=$OUTDIR+"\scrubbed-"+$_ 
    $IPs -Replace $IPREGEXSIMP, $PATTERN > $OUTFILES1
    Write-Output $_.FULLNAME $COUNT1.Matches.Count "-----------------------------------------------------" |
    Tee-Object -FilePath $SCRUBLOG -Append
    }#end foreach
}
}
"B"{$PATTERN='XXX.$2.XXX.$4'
Write-Host "
Replacing IPs with pattern: XXX.168.XXX.123"
if($DOMSTRING1){
    rm $SCRUBLOG
    Write-Output "============================" $TIMESTAMP "IP MATCH/REMOVE COUNT" "IP Pattern Used: $PATTERN" "String Used: $DOMPATTERN" "============================">$SCRUBLOG
    Get-childitem $INDIR -recurse |  
    foreach { 
    $IPs = Get-Content $_.FullName
    $COUNT1=$IPs | select-string -pattern $IPREGEXSIMP -AllMatches
    $COUNT2=$IPs | select-string -pattern $DOMSTRING1 -AllMatches
    $OUTFILES1=$OUTDIR+"\scrubbed-"+$_ 
    $IPs -Replace $IPREGEXSIMP, $PATTERN`
         -Replace $DOMSTRING1, $DOMPATTERN  > $OUTFILES1
    Write-Output $_.FULLNAME $COUNT1.Matches.Count $COUNT2.Matches.Count "-----------------------------------------------------" |
    Tee-Object -FilePath $SCRUBLOG -Append
    }#end foreach
}
Else{
    rm $SCRUBLOG
    Write-Output "============================" $TIMESTAMP "IP MATCH/REMOVE COUNT"  "IP Pattern Used: $PATTERN" "No other strings replaced" "============================">$SCRUBLOG
    Get-childitem $INDIR -recurse |  
    foreach { 
    $IPs = Get-Content $_.FullName
    $COUNT1=$IPs | select-string -pattern $IPREGEXSIMP -AllMatches
    $OUTFILES1=$OUTDIR+"\scrubbed-"+$_ 
    $IPs -Replace $IPREGEXSIMP, $PATTERN > $OUTFILES1
    Write-Output $_.FULLNAME $COUNT1.Matches.Count "-----------------------------------------------------" |
    Tee-Object -FilePath $SCRUBLOG -Append
    }#end foreach
}
}
"C"{$PATTERN='XXX.XXX.XXX.$4'
Write-Host "
Replacing IPs with pattern: XXX.XXX.XXX.123"
if($DOMSTRING1){
    rm $SCRUBLOG
    Write-Output "============================" $TIMESTAMP "IP MATCH/REMOVE COUNT" "IP Pattern Used: $PATTERN" "String Used: $DOMPATTERN" "============================">$SCRUBLOG
    Get-childitem $INDIR -recurse |  
    foreach { 
    $IPs = Get-Content $_.FullName
    $COUNT1=$IPs | select-string -pattern $IPREGEXSIMP -AllMatches
    $COUNT2=$IPs | select-string -pattern $DOMSTRING1 -AllMatches
    $OUTFILES1=$OUTDIR+"\scrubbed-"+$_ 
    $IPs -Replace $IPREGEXSIMP, $PATTERN`
         -Replace $DOMSTRING1, $DOMPATTERN  > $OUTFILES1
    Write-Output $_.FULLNAME $COUNT1.Matches.Count $COUNT2.Matches.Count "-----------------------------------------------------" |
    Tee-Object -FilePath $SCRUBLOG -Append
    }#end foreach
}
Else{
    rm $SCRUBLOG
    Write-Output "============================" $TIMESTAMP "IP MATCH/REMOVE COUNT"  "IP Pattern Used: $PATTERN" "No other strings replaced" "============================">$SCRUBLOG
    Get-childitem $INDIR -recurse |  
    foreach { 
    $IPs = Get-Content $_.FullName
    $COUNT1=$IPs | select-string -pattern $IPREGEXSIMP -AllMatches
    $OUTFILES1=$OUTDIR+"\scrubbed-"+$_ 
    $IPs -Replace $IPREGEXSIMP, $PATTERN > $OUTFILES1
    Write-Output $_.FULLNAME $COUNT1.Matches.Count "-----------------------------------------------------" |
    Tee-Object -FilePath $SCRUBLOG -Append
    }#end foreach
}
}
"D"{$PATTERN='XXX.XXX.XXX.XXX'
Write-Host "
Replacing IPs with pattern: XXX.XXX.XXX.XXX" -f Magenta
if($DOMSTRING1){
    rm $SCRUBLOG
    Write-Output "============================" $TIMESTAMP "IP MATCH/REMOVE COUNT" "IP Pattern Used: $PATTERN" "String Used: $DOMPATTERN" "============================">$SCRUBLOG
    Get-childitem $INDIR -recurse |  
    foreach { 
    $IPs = Get-Content $_.FullName
    $COUNT1=$IPs | select-string -pattern $IPREGEXSIMP -AllMatches
    $COUNT2=$IPs | select-string -pattern $DOMSTRING1 -AllMatches
    $OUTFILES1=$OUTDIR+"\scrubbed-"+$_ 
    $IPs -Replace $IPREGEXSIMP, $PATTERN`
         -Replace $DOMSTRING1, $DOMPATTERN  > $OUTFILES1
    Write-Output $_.FULLNAME $COUNT1.Matches.Count $COUNT2.Matches.Count "-----------------------------------------------------" |
    Tee-Object -FilePath $SCRUBLOG -Append
    }#end foreach
}
Else{
    rm $SCRUBLOG
    Write-Output "============================" $TIMESTAMP "IP MATCH/REMOVE COUNT"  "IP Pattern Used: $PATTERN" "No other strings replaced" "============================">$SCRUBLOG
    Get-childitem $INDIR -recurse |  
    foreach { 
    $IPs = Get-Content $_.FullName
    $COUNT1=$IPs | select-string -pattern $IPREGEXSIMP -AllMatches
    $OUTFILES1=$OUTDIR+"\scrubbed-"+$_ 
    $IPs -Replace $IPREGEXSIMP, $PATTERN > $OUTFILES1
    Write-Output $_.FULLNAME $COUNT1.Matches.Count "-----------------------------------------------------" |
    Tee-Object -FilePath $SCRUBLOG -Append
    }#end foreach
}
}
default{Write-Host "
Invalid Selection. Try Again." -f red
Exit
}
} #End Switch
#Script by Roberto Seldner