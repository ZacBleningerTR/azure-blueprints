#!/bin/bash

subscription_id=$1
resource_group=$2

if [[ -z $subscription_id || -z $resource_group ]];
then
	echo "ERROR: Proper usage: './createADGroups.sh {subscription_id} {resource_group}'"
	exit 1
fi

owner_ad_group="MA-$subscription_id-$resource_group-Owner"
contributor_ad_group="MA-$subscription_id-$resource_group-Owner"
reader_ad_group="MA-$subscription_id-$resource_group-Owner"

# set Azure subscription
az account set -s $subscription_id

# create AD groups for owner, contributor, and reader
az ad group create --display-name $owner_ad_group --mail-nickname $owner_ad_group --force false
az ad group create --display-name $contributor_ad_group --mail-nickname $contributor_ad_group --force false
az ad group create --display-name $reader_ad_group --mail-nickname $reader_ad_group --force false

# retrieve AD group object IDs
owner_object_id=$(az ad group show --group $owner_ad_group)
contributor_object_id=$(az ad group show --group $contributor_ad_group)
reader_object_id=$(az ad group show --group $reader_ad_group)

# assign custom roles to AD groups
az role assignment create --role "Custom-App-Owner-$subscription_id" --resource-group $resource_group --assignee-object-id $owner_object_id
az role assignment create --role "Custom-App-Contributor-$subscription_id" --resource-group $resource_group --assignee-object-id $contributor_object_id
az role assignment create --role "Reader" --resource-group $resource_group --assignee-object-id $reader_object_id
