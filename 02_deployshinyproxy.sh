ACR_NAME=shinyproxydemo
az acr build --registry $ACR_NAME --image shinyproxy:v1 shinyproxy.Dockerfile
az acr build --registry $ACR_NAME --image kube-proxy-sidecar:v1 kube-proxy-sidecar.Dockerfile
kubectl create -f shinyproxy.yaml
