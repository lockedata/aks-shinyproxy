ACR_NAME=shinyproxydemo
wget https://raw.githubusercontent.com/rstudio/shiny-examples/master/001-hello/app.R
wget https://raw.githubusercontent.com/cole-brokamp/rize/master/rize/Dockerfile shinyapp.Dockerfile
az acr build --registry $ACR_NAME --image shinyapp:v1 -f shinyapp.Dockerfile .
az acr build --registry $ACR_NAME --image shinyproxy:v1 -f shinyproxy.Dockerfile .
az acr build --registry $ACR_NAME --image kube-proxy-sidecar:v1 -f kube-proxy-sidecar.Dockerfile .
kubectl create -f shinyproxy.yaml
