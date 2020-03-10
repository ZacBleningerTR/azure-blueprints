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

# ${#myvar} use this to get string length to get exact end of cut length 

owner_ad_group_mail="$(echo $owner_ad_group | cut -c41-100)-mail"
contributor_ad_group_mail="$(echo $owner_ad_group | cut -c41-100)-mail"
reader_ad_group_mail="$(echo $owner_ad_group | cut -c41-100)-mail"

# create AD groups for owner, contributor, and reader
az ad group create --display-name "$owner_ad_group" --mail-nickname "$owner_ad_group_mail" --force false
az ad group create --display-name "$contributor_ad_group" --mail-nickname "$contributor_ad_group_mail" --force false
az ad group create --display-name "$reader_ad_group" --mail-nickname "$reader_ad_group_mail" --force false
