<#
#>

# Connect to Azure (will prompt if not already connected)

# Build the path to the JSON definition (assumes it's in the same folder)
# Read and convert the JSON
$roleDefinition = Get-Content -Path $jsonPath -Raw | ConvertFrom-Json
# Attempt to create the custom role
    New-AzRoleDefinition -Role $roleDefinition
    Write-Host "Custom role '$($roleDefinition.Name)' created successfully." -ForegroundColor Green
}
