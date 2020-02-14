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
New-AzADGroup -DisplayName $ownerADGroupName -MailNickname "$ownerADGroupName-mail"
New-AzADGroup -DisplayName $contributorADGroupName -MailNickname "$contributorADGroupName-mail"
New-AzADGroup -DisplayName $readerADGroupName -MailNickname "$readerADGroupName-mail"


