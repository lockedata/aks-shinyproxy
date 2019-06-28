# aks-shinyproxy
Deploy shinyproxy on Azure Kubernetes Service via the Cloud Shell (az cli)

This repo will:
- provision an Azure Kubernetes Service
- provision an Azure Cotnainer Registry for private repo storage
- build private images of a sample application, the shinyproxy, and a helper container (per [shinyconfig-examples](https://github.com/openanalytics/shinyproxy-config-examples/tree/master/03-containerized-kubernetes/shinyproxy-example))
- deploy a the shinyproxy service to the AKS cluster, and create a DNS subdomain that the shinyproxy is available at

## Instructions
1. Git clone to the cloud shell session
    + You can paste into the cloud shell with shift+insert
    + You can use git to get all the code `git clone https://github.com/lockedata/aks-shinyproxy`
    + You can then navigate to the code `cd aks-shinyproxy`
2. Amend names at the top of the script [`00_setup_resources.sh`](00_setup_resources.sh) to avoid naming conflicts
    + The cloud shell has nano available as an editor `nano 00_setup_resources.sh`
    + Save up by pressing ctrl+x then Y then enter
3. Run `00_setup_resources.sh`
    + Execute the script with `./00_setup_resources.sh`
    + You may need to enable execute permissions on scripts if you encounter errors later. Task can be performed with `chmod 777 00_setup_resources.sh`
4. Optionally, run `01_configure_helm.sh` if you want to do Helm stuff (`./01_configure_helm.sh`)
5. Amend [`shinyproxy.yaml`](shinyproxy.yaml), [`application.yml`](application.yml), and [`02_deployshinyproxy.sh`](02_deployshinyproxy.sh) with the ACR and AKS info
    + Much of the info required is either user specified or available by viewing the AKS resource in the Portal
6. Run `02_deployshinyproxy.sh`
7. Give everything a couple of minutes to update DNSwise then navigate to http://shinyproxy.k8sDNS
