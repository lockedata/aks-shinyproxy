# aks-shinyproxy
Deploy shinyproxy on Azure Kubernetes Service via the Cloud Shell (az cli)

This repo will:
- provision an Azure Kubernetes Service
- provision an Azure Cotnainer Registry for private repo storage
- build private images of a sample application, the shinyproxy, and a helper container (per [shinyconfig-examples](https://github.com/openanalytics/shinyproxy-config-examples/tree/master/03-containerized-kubernetes/shinyproxy-example))
- deploy a the shinyproxy service to the AKS cluster, and create a DNS subdomain that the shinyproxy is available at

## Instructions
1. Git clone to the local cloud shell session
2. Amend desired location etc in [`00_setup_resources.sh`](00_setup_resources.sh)
3. Run `00_setup_resources.sh`
4. Optionally, run `01_configure_helm.sh` if you want to do Helm stuff
5. Amend [`shinyproxy.yaml`](shinyproxy.yaml), [`application.yml`](application.yml), and [`02_deployshinyproxy.sh`](02_deployshinyproxy.sh) with the ACR and AKS info
6. Run `02_deployshinyproxy.sh`
7. Give everything a couple of minutes to update DNSwise then navigate to http://shinyproxy.k8sDNS
