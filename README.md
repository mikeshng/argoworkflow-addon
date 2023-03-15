# argoworkflow-addon
** Now bundled in https://github.com/mikeshng/argo-workflow-multicluster **


PoC ArgoWorkflow Addon for Open Cluster Management (OCM).

By applying this add-on to your OCM hub cluster, automatically Argo Workflow installation will be applied to all your `managed` (`spoke`) clusters and all your to be registered `managed` (`spoke`) clusters.
You can then apply a `ManifestWork` wrapping the `Workflow` CR on your `hub` cluster and the `Workflow` CR will be reconciled on your `managed` (`spoke`) clusters.

Inside the `controllers/manifests` folder it contains the Argo Workflow install version of:
```
v3.4.2
```

# Prerequisite

Setup an Open Cluster Management environment. See: https://open-cluster-management.io/getting-started/quick-start/ for more details

# Get started

Git Clone the repo.

Edit the `Makefile` and replace the `docker.io/mikeshng` to the registry of your choice.

Create the image:

```
make docker-build
```

Push the image:

```
make docker-push
```

Edit the `deploy/deployment.yaml` file and replace the `docker.io/mikeshng` to the registry of your choice.

Deploy the add-on the OCM `hub` cluster:

```
$ kubectl apply -f deploy
$ kubectl -n open-cluster-management get deploy
NAME                      READY   UP-TO-DATE   AVAILABLE   AGE
argoworkflow-addon-controller   1/1     1            1           29s
```

The controller will automatically install the add-on to all `managed` (`spoke`) clusters.

Validate the add-on is installed on a `managed` (`spoke`) cluster:

```
kubectl -n argo get deploy
NAME                  READY   UP-TO-DATE   AVAILABLE   AGE
argo-server           1/1     1            1           24s
workflow-controller   1/1     1            1           24s
```

You can also validate the add-on is available on the `hub` cluster:

```
$ kubectl -n cluster1 get managedclusteraddon # replace "cluster1" with your managed cluster name
NAME          AVAILABLE   DEGRADED   PROGRESSING
argoworkflow   True                   
```

Deploy an example of a `ManifestWork` wrapping a `Workflow` CR on the `hub` cluster:

```
kubectl -n cluster1 apply -f example # replace "cluster1" with your managed cluster name
```

Validate the `Workflow` is created on the `managed` (`spoke`) cluster:

```
$ kubectl -n default get argoworkflow
NAME                       STATUS      AGE   MESSAGE
hello-world-multicluster   Succeeded   16s   
```
