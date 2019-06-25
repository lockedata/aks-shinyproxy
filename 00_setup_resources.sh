AKS_RESOURCE_GROUP=shinyproxydemo
AKS_CLUSTER_NAME=shinyproxydemo
ACR_RESOURCE_GROUP=shinyproxydemo
ACR_NAME=shinyproxydemo
LOCATION=uksouth

az group create --name $AKS_RESOURCE_GROUP --location $LOCATION
# CREATE AKS
version=$(az aks get-versions -l uksouth --query 'orchestrators[-1].orchestratorVersion' -o tsv)
az aks create --resource-group $AKS_RESOURCE_GROUP --name $AKS_CLUSTER_NAME --location $LOCATION --enable-addons monitoring --kubernetes-version $version
az aks get-credentials --resource-group $AKS_RESOURCE_GROUP --name $AKS_CLUSTER_NAME

# CREATE ACR
az acr create --resource-group $ACR_RESOURCE_GROUP --name $ACR_NAME --location $LOCATION --sku Basic
CLIENT_ID=$(az aks show --resource-group $AKS_RESOURCE_GROUP --name $AKS_CLUSTER_NAME --query "servicePrincipalProfile.clientId" --output tsv)
ACR_ID=$(az acr show --name $ACR_NAME --resource-group $ACR_RESOURCE_GROUP --query "id" --output tsv)

# GRANT AKS READ ON ACR
az role assignment create --assignee $CLIENT_ID --role acrpull --scope $ACR_ID

