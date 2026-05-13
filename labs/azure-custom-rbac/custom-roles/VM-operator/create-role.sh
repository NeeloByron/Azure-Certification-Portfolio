#!/bin/bash
JSON_FILE="$(dirname "$0")/role-definition.json"

# Create the custom role
az role definition create --role-definition "@${JSON_FILE}"

if [ $? -eq 0 ]; then
    echo "Custom role created successfully."
else
    echo "Failed to create custom role."
fi

