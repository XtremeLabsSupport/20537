

#Create the Resource Group
New-AzureRmResourceGroup -Name "RG-Local-SCOM" -Location local
#Deploy the template
New-AzureRmResourceGroupDeployment -Name SCOM -ResourceGroupName RG-Local-SCOM -TemplateFile "C:\Media\ModuleFiles\Module06\SCOM-Deploy\SCOM.JSON" -TemplateParameterFile "C:\Media\ModuleFiles\Module06\SCOM-Deploy\SCOM.parameters.json" -Verbose 

