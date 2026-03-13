# Install IIS

# Create a simple HTML page
$content = "<html><body><h1>Hello from VM in Availability Set!</h1><p>VM Name: $env:computername</p></body></html>"

# Optionally start IIS (it starts automatically)
