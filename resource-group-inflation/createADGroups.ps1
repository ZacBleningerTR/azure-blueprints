# Set subscription

param(
[string]$subId,
[string]$rgName
)

$ownerADGroupName="MA-$subId-$rgName-Owner"
$contributorADGroupName="MA-$subId-$rgName-Contributor"
$readerADGroupName="MA-$subId-$rgName-Reader"

# set Azure subscription
Set-AzContext -SubscriptionId $subId 

# create AD groups for owner, contributor, and reader
New-AzADGroup -DisplayName $ownerADGroupName -MailNickname "$ownerADGroupName-123"
New-AzADGroup -DisplayName $contributorADGroupName -MailNickname "$contributorADGroupName-123"
New-AzADGroup -DisplayName $readerADGroupName -MailNickname "$readerADGroupName-123"


