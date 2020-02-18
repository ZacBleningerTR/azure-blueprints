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
New-AzADGroup -DisplayName $ownerADGroupName -MailNickname "$ownerADGroupNametest1"
New-AzADGroup -DisplayName $contributorADGroupName -MailNickname "$contributorADGroupNametest1"
New-AzADGroup -DisplayName $readerADGroupName -MailNickname "$readerADGroupNametest1"


