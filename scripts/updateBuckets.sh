#!/bin/bash

#  Run step for all changed translation files files and put into Github Env
englishFilePaths=()

for file in $2; do
    if [[ ${file:0:7} = "public/locales/en" ]]; then
        englishFilePaths+=(${file:7})
    fi;
done

echo "This is the config path: $englishFilePaths"
echo "first argument: $1"

buckets=( $1en/ $1de/)

# Get rid of the first value because it is going to be the parent directory of en/ede

echo "Buckets:  $buckets"
#  Loop through the GCP buckets, and add the files

cd config 

for changedFile in $englishFilePaths; do
    for bucket in $1en/; do
        echo "This is the bucket: $bucket "
        p=$bucket$changedFile 
        echo THIS IS: "$p"
        echo "this is the changed file: " $changedFile
        gsutil cp $changedFile $p || continue
    done;
done;

germanFilePaths=()

for file in $2; do
    if [[ ${file:0:7} = "public/locales/de" ]]; then
        germanFilePaths+=(${file:7})
    fi;
done


for changedFile in $germanFilePaths; do
    for bucket in $1de/; do
        echo "This is the bucket: $bucket "
        p=$bucket$changedFile 
        echo THIS IS: "$p"
        echo "this is the changed file: " $changedFile
        gsutil cp $changedFile $p || continue
    done;
done;
