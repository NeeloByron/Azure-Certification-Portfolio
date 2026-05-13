# Azure AKS Multi‑Container Voting App
This project deploys a classic voting application on Azure Kubernetes Service (AKS). The application consists of two components:
- **Frontend**: A Python/Flask web app that presents a voting interface (Cats vs. Dogs).
The frontend is exposed to the internet using an Azure Load Balancer (Kubernetes Service of type `LoadBalancer`). The images are stored in a private Azure Container Registry (ACR), and AKS pulls them securely.
## Architecture

[Internet User]
v
+------------------------------------------+
| Azure Load Balancer |
| (Public IP) |
+------------------------------------------+
|
v
+------------------------------------------+
| +----------------+ +---------------+ |
| | Frontend Pods | | Redis Pod | |
| | (Python/Flask) | | (Cache) | |
| +----------------+ +---------------+ |
| | | |
| +-------------------+ |
| Internal traffic |
+------------------------------------------+
|
v
+------------------------------------------+
| Azure Container Registry (ACR) |
| - Stores frontend image |
| - Redis image pulled from Docker Hub |
+------------------------------------------+


- Azure subscription (Owner or Contributor)
- Azure CLI installed and logged in (`az login`)
- Docker installed locally (for building the image)
- Git (to clone the sample repository)

## Deployment

### Automated Script

The `deploy.sh` script automates everything:

1. **Create resource group** and ACR.
2. **Build and push** the voting app image to ACR.
3. **Create AKS cluster** with ACR attached.
5. **Wait** for the Load Balancer external IP and display it.
Run the script:

```bash
chmod +x deploy.sh
./deploy.sh
