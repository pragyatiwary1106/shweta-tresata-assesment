# Azure Kubernetes Service (AKS) Terraform Infrastructure

This repository contains Terraform configuration for deploying Azure Kubernetes Service (AKS) infrastructure with auto-scaling capabilities.

## Architecture

The infrastructure is organized using a modular approach with the following components:

### Modules
- **Resource Group Module** (`modules/rg/`) - Creates Azure Resource Group
- **AKS Module** (`modules/aks/`) - Deploys AKS cluster with auto-scaling enabled

### Features
- **Auto-scaling**: Node pool automatically scales between min/max node counts
- **System-assigned identity**: Managed identity for AKS cluster
- **Environment-specific configurations**: Separate tfvars for dev and prod
- **Remote state management**: Azure Storage backend for Terraform state

## File Structure

```
terraform/
├── modules/
│   ├── aks/
│   │   ├── aks.tf          # AKS cluster resource
│   │   ├── variables.tf    # AKS module variables
│   │   └── output.tf       # AKS outputs (kubeconfig, certificates)
│   └── rg/
│       ├── rg.tf           # Resource group resource
│       ├── variables.tf    # RG module variables
│       └── output.tf       # RG outputs
├── environment/
│   ├── dev/
│   │   └── dev.tfvars      # Development environment variables
│   └── prod/
│       └── prod.tfvars     # Production environment variables
├── aks.tf                  # Main module calls
├── provider.tf             # Azure provider configuration
├── backend.tf              # Remote state configuration
├── variables.tf            # Root module variables
└── output.tf               # Root module outputs
```

## Prerequisites

- Azure CLI installed and authenticated
- Terraform >= 1.0
- Azure subscription with appropriate permissions
- Azure Storage Account for remote state (configured in backend.tf)

## Configuration

### Environment Variables
Set the following environment variable for backend authentication:
```bash
export ARM_ACCESS_KEY="your-storage-account-access-key"
```

### Key Configuration Files

**Dev Environment** (`environment/dev/dev.tfvars`):
- Resource Group: `dev-rg`
- AKS Cluster: `Akscluster-pragya`
- Location: `West Europe`
- VM Size: `Standard_B2s`
- Auto-scaling: 1-5 nodes

**Prod Environment** (`environment/prod/prod.tfvars`):
- Resource Group: `prod-rg`
- AKS Cluster: `Akscluster-prod-pragya`
- Location: `West Europe`
- VM Size: `Standard_D2_v2`

## Deployment

### Initialize Terraform
```bash
cd terraform
terraform init
```

### Plan Deployment
```bash
# For development
terraform plan -var-file="environment/dev/dev.tfvars"

# For production
terraform plan -var-file="environment/prod/prod.tfvars"
```

### Apply Configuration
```bash
# For development
terraform apply -var-file="environment/dev/dev.tfvars"

# For production
terraform apply -var-file="environment/prod/prod.tfvars"
```

## AKS Configuration

### Auto-scaling
- **Enabled**: Node pool automatically scales based on workload
- **Min Count**: 1 node (configurable)
- **Max Count**: 5 nodes (configurable)
- **Initial Count**: Set to min_count value

### Security
- **Identity**: System-assigned managed identity
- **Secrets**: No hardcoded credentials in code
- **Access**: Backend authentication via environment variables

## Outputs

The infrastructure provides the following outputs:
- **client_certificate**: AKS client certificate (sensitive)
- **kube_config**: Raw kubeconfig for cluster access (sensitive)

## Best Practices Implemented

- Modular architecture for reusability
- Environment-specific configurations
- Remote state management
- Auto-scaling for cost optimization
- Managed identity for security
- Sensitive output handling
- Proper resource tagging

## Usage Notes

1. Ensure Azure Storage Account exists before running terraform init
2. Set ARM_ACCESS_KEY environment variable for backend authentication
3. Review and customize tfvars files for your requirements
4. Use appropriate VM sizes for your workload requirements