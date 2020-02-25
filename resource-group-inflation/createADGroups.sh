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

# retrieve custom contributor and owner role templates
curl https://raw.githubusercontent.com/ZacBleningerTR/azure-blueprints/master/resource-group-inflation/Custom-App-Contributor.json > Custom-App-Contributor.json
curl https://raw.githubusercontent.com/ZacBleningerTR/azure-blueprints/master/resource-group-inflation/Custom-App-Owner.json > Custom-App-Owner.json

# replace parameter with subscription id
sed -e 's/%sub%/$subscription_id/g' Custom-App-Contributor.json
sed -e 's/%sub%/$subscription_id/g' Custom-App-Owner.json

# create role definitions
az role definition create --role-definition @Custom-App-Contributor.json
az role definition create --role-definition @Custom-App-Owner.json
