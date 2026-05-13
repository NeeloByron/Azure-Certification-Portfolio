#!/bin/bash
# This script creates a policy definition and assigns it at the subscription level.

# Variables - customize these
ALLOWED_LOCATIONS='["eastus", "westus"]'  # Change to your desired regions
POLICY_NAME="allowed-locations-policy"
DISPLAY_NAME="Allow only East US and West US locations"
SUBSCRIPTION_ID=$(az account show --query id -o tsv)

echo "Creating policy definition '$POLICY_NAME'..."
az policy definition create \
    --name "$POLICY_NAME" \
    --display-name "$DISPLAY_NAME" \
    --description "This policy denies resource creation outside of allowed locations." \
    --rules '{
      "if": {
        "not": {
          "field": "location",
          "in": '"$ALLOWED_LOCATIONS"'
        }
      },
      "then": {
        "effect": "deny"
      }
    }' \
    --mode All

echo "Assigning policy at subscription scope..."
az policy assignment create \
    --name "$POLICY_NAME-assignment" \
    --policy "$POLICY_NAME" \
    --scope "/subscriptions/$SUBSCRIPTION_ID"

echo "Policy created and assigned successfully."
