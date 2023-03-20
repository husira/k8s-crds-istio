#!/bin/bash

if [[ $1 =~ ^[0-9]{1,2}\.[0-9]{1,2}.[0-9]{1,2}$ ]]; then
    version=$1;
else
    echo "::: Set a valid vesion";
    echo "::: For example: update-crds.sh 1.16.1"
    exit 1;
fi

rm -rf customresourcedefinition-*;
curl -LO https://raw.githubusercontent.com/istio/istio/${version}/manifests/charts/base/crds/crd-all.gen.yaml;

if [ $(uname -s) = "Darwin" ]; then OSX_SED_APPENDIX="_to_be_remove"; fi;
grep -El '^# DO NOT EDIT.*$' crd-all.gen.yaml | xargs -r -n 1 sed -i${OSX_SED_APPENDIX} -E '/^# DO NOT EDIT.*$$/d';
if [ $(uname -s) = "Darwin" ]; then rm -f crd-all.gen.yaml${OSX_SED_APPENDIX}; fi;

kubectl-slice --input-file=crd-all.gen.yaml --output-dir=./crd/

rm -rf crd-all.gen.yaml;
