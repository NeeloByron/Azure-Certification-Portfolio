yourdomain.onmicrosoft.com#!/bin/bash
# Create users in Azure AD
# Replace "yourdomain.onmicrosoft.com" with your actual tenant domain

echo "Creating users..."

az ad user create --display-name "Test User1" \
  --user-principal-name testuser1@tmasedi1outlook.onmicrosoft.com \
  --password "ComplexPassword123!" \
  --mail-nickname "testuser1"

az ad user create --display-name "Test User2" \
  --user-principal-name testuser2@tmasedi1outlook.onmicrosoft.com \
  --password "ComplexPassword123!" \
  --mail-nickname "testuser2"

echo "Users created."
