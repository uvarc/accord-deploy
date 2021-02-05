Currently there are two parts to deploying an ACCORD environment to a cluster:

1. Install the ArgoCD app for the cluster in the `clusters/` directory. The cluster app only contains cluster-specific secrets used by ACCORD, and should only be updated infrequently when a new environment (e.g. `staging`) is added.
2. Install / update environments from the `accord*/` directories. These should be cluster-agnostic; i.e., the only difference between `accord-dev` on an AWS vs. on-prem cluster should be the URL provided when the app is initially deployed.

## Naming of Secrets

The current convention is to store all secrets for the cluster in an `accord-cluster` namespace, and to name the secret `<namespace>-<secretname>`, e.g. `accord-dev-mongo`.

## Secrets in Git

Secrets for ACCORD deployments are managed using Bitnami's [sealed secrets](https://github.com/bitnami-labs/sealed-secrets). For our deployments, each uniq cluster (David's **lj** home cluster, the AWS cluster) has it's own private key stored in the cluster and backed-up elsewhere. The "secrets" stored in Git are encrypted with the public key for the cluster. When the sealed secret is created on the cluster, the bitnami controller automatically creates the corresponding secret, which never appears in Git.

### Setting Up Sealed Secrets

For our clusters, we're manually generating a key/cert and importing in to the cluster prior to installing sealed secrets. The key can then be saved to a secure location and used to reinstall if the cluster needs to be rebuilt from scratch without invalidating all the existing sealed secrets.

1. Generate a key/cert per [these instructions](https://github.com/bitnami-labs/sealed-secrets/blob/master/docs/bring-your-own-certificates.md); **NOTE:** ignore the bit about deleting the pod, since we're creating this secret *before* installing the controller.
2. Save / share the private key as appropriate.
3. Installed sealed secrets per docs

## Adjusting Environments by Cluster

In the event that an environment such as `accord-dev` is deployed to multiple clusters, cluster-specific values such as domain can be set as a parameter to the application, e.g.:
```
argocd app set accord -p appDomain="uvarc.io"
```

The preferred means of making this kind of cluster-specific change is to add it to the app definition for the cluster:

```yaml
# aws-accord-dev.yaml
...
  source:
    helm:
      parameters:
      - name: appDomain
        value: "uvarc.io"
...
```
