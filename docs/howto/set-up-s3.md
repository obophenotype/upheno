# How to set yourself up for S3

To be able to upload new uPheno release to the uPheno S3 bucket, you need to set yourself up for S3 first.

1. [Download and install AWS CLI](#Download and install aws CLI)
2. [Obtain secrets from BBOP](#Obtain secrets from BBOP)
3. [Add configuration for secrets](#Add configuration for secrets)


# 1. Download and install AWS CLI

The most convenient way to interact with S3 is the [AWS Command Line Interface (CLI)](https://aws.amazon.com/cli/). You can find the installers and install instructions on that page (different depending on your Operation System):
- For [Mac](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-mac.html)
- For [Windows](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-windows.html)

# 2. Obtain secrets from BBOP

Next, you need to ask someone at BBOP (such as Chris Mungall or Seth Carbon) to provide you with an account that gives you access to the BBOP s3 buckets. You will have to provide a username. You will receive:
- User name
- Access key ID-
- Secret access key
- Console link to sign into bucket

# 3. Add configuration for secrets

You will now have to set up your local system. You will create two files:

```
$ less ~/.aws/config 
[default]
region = us-east-1
```

and 

```
$ less ~/.aws/credentials
[default]
aws_access_key_id = ***
aws_secret_access_key = ***
```

in `~/.aws/credentials` make sure you add the correct keys as provided above.

# 4. Write to your bucket

Now, you should be set up to write to your s3 bucket. Note that in order for your data to be accessible through `https` after your upload, you need to add `--acl public read`.

```
aws s3 sync --exclude "*.DS_Store*" my/data-dir s3://bbop-ontologies/myproject/data-dir --acl public-read
```

If you have previously pushed data to the same location, you wont be able to set it to "publicly readable" by simply rerunning the sync command. If you want to publish previously private data, follow the instructions [here](https://aws.amazon.com/premiumsupport/knowledge-center/read-access-objects-s3-bucket/), e.g.:

```
aws s3api put-object-acl --bucket s3://bbop-ontologies/myproject/data-dir --key exampleobject --acl public-read
```