#!/bin/bash
# Create groups in Azure AD

echo "Creating groups..."

az ad group create --display-name "TestGroup1" --mail-nickname "TestGroup1"
az ad group create --display-name "TestGroup2" --mail-nickname "TestGroup2"

echo "Groups created."
