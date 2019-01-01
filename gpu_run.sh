#!/bin/bash

# specify job input
export AWS_DEFAULT_OUTPUT=json
export AWS_DEFAULT_REGION=us-west-2

# run test codes
cd /work
echo "nvidia-smi!!!!!" > gpu-batch.out
nvidia-smi >> gpubatch.out

# upload output to S3
TIMESTAMP=`date +%Y%m%d%H%M`
aws s3 cp ./gpubatch.out s3://<bucket-name>/output/$AWS_BATCH_JOB_ID"-"$TIMESTAMP
