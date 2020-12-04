#!/bin/bash
#
# https://github.com/umiterkol/AWS_SHELL_UPLOAD
#


export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
export AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
echo "Liste des fichiers."
aws --endpoint-url http://s3.bucket.local/ s3 ls --recursive --human-readable --summarize s3://test_server

## Copier le fichier dans le bucket

aws --endpoint-url http://s3.bucket.local/ s3 cp /root/reverse.php s3://test_server/reverse.php

echo "Vérifiez si le fichier est téléchargé"
aws --endpoint-url http://s3.bucket.local/ s3 ls --recursive --human-readable --summarize s3://test_server

# Vérifier si le fichier existe
echo "Vérification sur s3.bucket"

curl --write-out "%{http_code}\n" --silent --output /dev/null http://s3.bucket.local/test_server/reverse.php
resp=404
while [[ $resp -eq 404 ]]; do
    resp=$(curl --write-out "%{http_code}\n" --silent --output /dev/null http://s3.bucket.local/test_server/reverse.php)
    echo $resp
    sleep 0.1;
done

