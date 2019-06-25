ACR_NAME=shinyproxydemo
az acr build --registry $ACR_NAME --image shinyproxy:v1 -f shinyproxy.Dockerfile .
az acr build --registry $ACR_NAME --image kube-proxy-sidecar:v1 -f kube-proxy-sidecar.Dockerfile .
kubectl create -f shinyproxy.yaml
