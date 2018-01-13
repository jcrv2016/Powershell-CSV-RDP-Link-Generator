#Import CSV, assign fields to variables, generate .RDP links
#This contains no exception handling

$ReadPath = Read-Host -Prompt 'Please input path of CSV to import'
$OutPath = Read-Host -Prompt 'Please output path for RDP links'
$Users = Import-Csv -Path $ReadPath
#Read in CSV            
foreach ($User in $Users)            
{   
    $userName = $User.'userName'          
    $hostName = $User.'hostName'            
  

    if ($User.'remoteGateway')
    {
    $remoteGateway = $User.'remoteGateway'
    }
    else
    {
    $remoteGateway = ''
    }

    $domainDNSName = $User.'domainDNSName'
    $domainShortName = $User.'domainShortName'

    if ($User.'promptForBothCredentials' -like '*yes*')
    {
    $promptcredentialonce = '0'
    }
    else
    {
    $promptcredentialonce = '1'
    }
#Output RDP link
$a = @"
screen mode id:i:2
use multimon:i:1
desktopwidth:i:1920
desktopheight:i:1080
session bpp:i:32
winposstr:s:0,1,566,48,1366,728
compression:i:1
keyboardhook:i:2
audiocapturemode:i:0
videoplaybackmode:i:1
connection type:i:7
networkautodetect:i:1
bandwidthautodetect:i:1
displayconnectionbar:i:1
enableworkspacereconnect:i:0
disable wallpaper:i:0
allow font smoothing:i:0
allow desktop composition:i:0
disable full window drag:i:1
disable menu anims:i:1
disable themes:i:0
disable cursor setting:i:0
bitmapcachepersistenable:i:1
full address:s:$hostName.$domainDNSName
audiomode:i:0
redirectprinters:i:1
redirectcomports:i:0
redirectsmartcards:i:1
redirectclipboard:i:1
redirectposdevices:i:0
autoreconnection enabled:i:1
authentication level:i:2
prompt for credentials:i:0
negotiate security layer:i:1
remoteapplicationmode:i:0
alternate shell:s:
shell working directory:s:
gatewayhostname:s:$remoteGateway
gatewayusagemethod:i:2
gatewaycredentialssource:i:4
gatewayprofileusagemethod:i:1
promptcredentialonce:i:$promptcredentialonce
gatewaybrokeringtype:i:0
use redirection server name:i:0
rdgiskdcproxy:i:0
kdcproxyname:s:
drivestoredirect:s:
username:s:$domainShortName\$userName
"@
$a  | Out-File -filepath $OutPath\$userName$hostName.rdp           
}


