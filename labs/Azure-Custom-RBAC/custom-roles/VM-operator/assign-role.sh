#!/bin/bash
ROLE_NAME="Virtual Machine Operator"
ASSIGNEE_OBJECT_ID="user-or-group-object-id"   # e.g., user's object ID
SCOPE="/subscriptions/326a16fa-cf9a-44d4-97ee-ab727a79f3d8/resourceGroups/YourRG"

# Assign the role
az role assignment create \
    --role "$ROLE_NAME" \
    --assignee-object-id "$ASSIGNEE_OBJECT_ID" \
    --scope "$SCOPE"

echo "Role assigned."
