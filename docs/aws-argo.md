## ArgoCD on the AWS Cluster

### Installation
ArgoCD was installed on the AWS cluster using `clusters/aws/argocd/install-argocd.yaml`. This is essentially the stock `install.yaml` with the aws cluster-specific ingress appended, and the `--insecure` flag added to `argocd-server` process to allow SSL termination in the ingress. Note that there is only an ingress for the web UI, and the `argocd` command should be used with port forwarding.

Installation:
```
$ kubectl create namespace argocd
$ kubectl -n argocd apply -f install-argocd.yaml
```

### Upgrading
To upgrade the install:
* Grab the latest yaml file and save it as `upgrade-argocd.yaml`
* Update the deployment for argocd-server and add the `--insecure flag`
* Apply the update with `$ kubectl -n argocd apply -f upgrade-argocd.yaml`
