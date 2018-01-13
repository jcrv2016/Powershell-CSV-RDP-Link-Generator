# Powershell-CSV-RDP-Link-Generator
Create RDP Links from CSV List

To use, modify 'TEMPLATE.CSV', or create your own csv.
There is no internal error-handling in this script. 
Script cannot create a new folder.

In the csv, leave 'promptForBothCredentials' blank, if you do not want to have user enter both sets of credentials (for gateway and remote machine).
Leave 'remoteGateway' blank, if you are not using a remote gateway server.
