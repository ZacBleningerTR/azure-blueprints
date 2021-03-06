# Set subscription

param(
[string]$subId,
[string]$rgName
)

$ownerADGroupName="MA-$subId-$rgName-Owner"
$contributorADGroupName="MA-$subId-$rgName-Contributor"
$readerADGroupName="MA-$subId-$rgName-Reader"

Write-Host "ownerADGroupName: $ownerADGroupName"
Write-Host "contributorADGroupName: $contributorADGroupName"
Write-Host "readerADGroupName: $readerADGroupName"

# set Azure subscription
Set-AzContext -SubscriptionId $subId 

# create AD groups for owner, contributor, and reader
New-AzADGroup -DisplayName $ownerADGroupName -MailNickname $ownerADGroupName
New-AzADGroup -DisplayName $contributorADGroupName -MailNickname $contributorADGroupName
New-AzADGroup -DisplayName $readerADGroupName -MailNickname $readerADGroupName


