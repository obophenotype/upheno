# How to run a uPheno 2 release

In order to run a release you will have to have completed the steps to [set up s3](set-up-s3.md).

1. Clone https://github.com/obophenotype/upheno-dev
2. `cd src/scripts`
3. `sh upheno_pipeline.sh`
4. `cd ../ontology`
5. `make prepare_upload S3_VERSION=2022-06-19`
6. `make deploy S3_VERSION=2022-06-19`
