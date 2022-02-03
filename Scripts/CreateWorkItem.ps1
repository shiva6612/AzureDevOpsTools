#Authentication in Azure DevOps
$AzureDevOpsPAT = 'coslmegb525wbm7trjlzxvzjzvq4kyqdhsfrdnzo2msz3oseaplq'
$AzureDevOpsAuthenicationHeader = @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($AzureDevOpsPAT)")) }

$OrganizationName = "shivaorg1"
$UriOrganization = "https://dev.azure.com/$($OrganizationName)/"

#Lists all projects in your organization
$uriAccount = $UriOrganization + "_apis/projects?api-version=5.1"
Invoke-RestMethod -Uri $uriAccount -Method get -Headers $AzureDevOpsAuthenicationHeader 


#Create a work item

$WorkItemType = "epic"
$WorkItemTitle = "Test from Powershell"
$WorkItemDescription = "Test Description"
$ProjectName = "sample_api";


$uri = $UriOrganization + $ProjectName + "/_apis/wit/workitems/$" + $WorkItemType + "?api-version=5.1"
echo $uri

$body="[
  {
    `"op`": `"add`",
    `"path`": `"/fields/System.Title`",
    `"value`": `"$($WorkItemTitle)`"
  },
  {
    `"op`": `"add`",
    `"path`": `"/fields/System.AssignedTo`",
    `"from`": null,
    `"value`": `"chirumamilla.a@ad.infosys.com`"
  },
  {
    `"op`": `"add`",
    `"path`": `"/fields/System.Description`",
    `"from`": null,
    `"value`": `"$($WorkItemDescription)`"
  },
  {
    `"op`": `"add`",
    `"path`": `"/fields/System.AreaPath`",
    `"value`": `"sample_api`"
  }
]"

Invoke-RestMethod -Uri $uri -Method POST -Headers $AzureDevOpsAuthenicationHeader -ContentType "application/json-patch+json" -Body $body
