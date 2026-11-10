#!/usr/bin/env bash

set -e
data=/nfs/production/parkinso/spot/upheno2/src/scripts

cd $data
#singularity pull docker://obolibrary/odkfull


singularity exec --pwd $data docker://obolibrary/odkfull:v1.3.1 python3 upheno_prepare.py ../curation/upheno-config.yaml
singularity exec --pwd $data docker://obolibrary/odkfull:v1.3.1 python3 upheno_create_profiles.py ../curation/upheno-config.yaml

singularity exec --pwd $data docker://obolibrary/odkfull:v1.3.1 python3 upheno-stats.py ../curation/upheno-config.yaml

cd ../ontology/

echo Running command from $(pwd)
singularity exec docker://obolibrary/odkfull:v1.4.1 make o sim reports

echo "Release successfully completed, ready to deploy."


