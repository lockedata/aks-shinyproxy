AKS_RESOURCE_GROUP=shinyproxydemo
AKS_CLUSTER_NAME=shinyproxydemo
ACR_RESOURCE_GROUP=shinyproxydemo
ACR_NAME=shinyproxydemo
LOCATION=uksouth
SERVICE_PRINCIPAL_NAME=acr-service-principal

az group create --name $AKS_RESOURCE_GROUP --location $LOCATION
# CREATE AKS
version=$(az aks get-versions -l uksouth --query 'orchestrators[-1].orchestratorVersion' -o tsv)
az aks create --resource-group $AKS_RESOURCE_GROUP --name $AKS_CLUSTER_NAME --location $LOCATION --enable-addons monitoring --kubernetes-version $version
az aks get-credentials --resource-group $AKS_RESOURCE_GROUP --name $AKS_CLUSTER_NAME
az aks enable-addons --resource-group $AKS_RESOURCE_GROUP --name $AKS_CLUSTER_NAME --addons http_application_routing

# CREATE ACR
az acr create --resource-group $ACR_RESOURCE_GROUP --name $ACR_NAME --location $LOCATION --sku Basic

# GRANT AKS READ ON ACR
CLIENT_ID=$(az aks show --resource-group $AKS_RESOURCE_GROUP --name $AKS_CLUSTER_NAME --query "servicePrincipalProfile.clientId" --output tsv)
ACR_ID=$(az acr show --name $ACR_NAME --resource-group $ACR_RESOURCE_GROUP --query "id" --output tsv)
ACR_LOGIN_SERVER=$(az acr show --name $ACR_NAME --query loginServer --output tsv)
az role assignment create --assignee $CLIENT_ID --role acrpull --scope $ACR_ID
SP_PASSWD=$(az ad sp create-for-rbac --name http://$SERVICE_PRINCIPAL_NAME --role acrpull --scopes $ACR_ID --query password --output tsv)
CLIENT_ID=$(az ad sp show --id http://$SERVICE_PRINCIPAL_NAME --query appId --output tsv)
kubectl create secret docker-registry acr-auth --docker-server $ACR_LOGIN_SERVER --docker-username $CLIENT_ID --docker-password $SP_PASSWD --docker-email notarealemail@itsalocke.com
