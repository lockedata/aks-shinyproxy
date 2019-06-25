# aks-shinyproxy
Deploying shinyproxy on Azure Kubernetes Service via the Cloud Shell (az cli)

1. Git clone to the local cloud shell session
2. Amend desired location etc in [`00_setup_resources.sh`](00_setup_resources.sh)
3. Run `00_setup_resources.sh`
4. Optionally, run `01_configure_helm.sh`
5. Amend [`shinyproxy.yaml`](shinyproxy.yaml) with k8s domain name
6. Run `02_deployshinyproxy.sh`
7. Give everything a couple of minutes to update DNSwise then navigate to http://shinyproxy.k8sDNS
