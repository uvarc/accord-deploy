## ArgoCD on the AWS Cluster

ArgoCD was installed on the AWS cluster using `clusters/aws/argocd/install-argocd.yaml`. This is essentially the stock `install.yaml` with the aws cluster-specific ingress appended. Note that there is only an ingress for the web UI, and the `argocd` command should be used with port forwarding.
