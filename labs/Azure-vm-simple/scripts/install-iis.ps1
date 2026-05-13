# PowerShell script to install IIS and create a default page
Install-WindowsFeature -Name Web-Server -IncludeManagementTools
$content = "<html><body><h1>Hello from Azure VM!<h1><p>Deployed via Custom Script Extension.</p></body></html>"
Set-Content -Path "c:\inetpub\wwwroot\index.html" -Value $content

