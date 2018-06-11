

#Resolve the IPs to be added to the Zone during creation
[string]$SaMslMediaIP = (Resolve-DnsName -Name samslmedia.blob.local.azurestack.external).IpAddress
[string]$AdminManagementIP = (Resolve-DnsName -Name adminmanagement.local.azurestack.external).IpAddress

[string]$DNSPrefix= (Read-Host -Prompt "Enter your username, e.g. ASUserX").ToLower()

#Path to the GitHub based JSON to deploy
$GitHubPath = "https://raw.githubusercontent.com/RyanBoud/AzureStack/master/Active-Directory/azuredeploy.json"

#Create the Parameters Hashatable for use with the template deployment
$params = @{
    "adminUsername" = "DemoAdmin"
    "adminPassword" = "Password12345"
    "domainName" = "ad.contoso.com"
    "dnsPrefix" = $DNSPrefix
    "samslmediaip" = $SaMslMediaIP 
    "AdminManagementIP" = $AdminManagementIP
}

#Create the Resource Group
$RGName = "RG-Local-ActiveDirectory"
New-AzureRmResourceGroup -Name $RGName -Location local
#Deploy the template
New-AzureRmResourceGroupDeployment -ResourceGroupName $RGName -TemplateParameterObject $params -TemplateUri $GitHubPath -Name ADTest