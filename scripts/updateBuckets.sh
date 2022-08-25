#!/bin/bash

#  Run step for all changed files and put into Github Env
configPaths=()

for file in $2; do
    if [[ ${file:0:7} = "config/" ]]; then
        configPaths+=(${file:7})
    fi;
done

echo "This is the config path: $configPaths"
echo "first argument: $1"

buckets=$( $1/en/ $1/de/ )

# Get rid of the first value because it is going to be the parent directory of en/ede

echo "Buckets:  $buckets"
#  Loop through the GCP buckets, and add the files

cd config 

for changedFile in $configPaths; do
    for bucket in $buckets; do
        echo "This is the bucket: $bucket "
        p=$bucket$changedFile 
        echo THIS IS: "$p"
        echo "this is the changed file: " $changedFile
        gsutil cp $changedFile $p || continue
    done;
done;

