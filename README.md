# Separate File

Run the script update-crds.sh <version>

```
curl -LO https://raw.githubusercontent.com/istio/istio/1.16.1/manifests/charts/base/crds/crd-all.gen.yaml
kubectl-slice --input-file=crd-all.gen.yaml --output-dir=.
```
