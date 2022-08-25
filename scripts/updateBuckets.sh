#!/bin/bash

#  Run step for all changed translation files files and put into Github Env
englishFilePaths=()

echo "2 : $2";

for file in $2; do
    echo "File: $file"
    if [[ ${file:0:18} = "public/locales/en/" ]]; then
        englishFilePaths+=(${file:18})
    fi;
done

echo "This is the english files path: $englishFilePaths"
echo "first argument: $1"

# Get rid of the first value because it is going to be the parent directory of en/ede

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

cd ..

germanFilePaths=()

for file in $2; do
    echo "File again: $file"
    if [[ ${file:0:18} = "public/locales/de/" ]]; then
        germanFilePaths+=(${file:18})
    fi;
done

cd config

for changedFile in $germanFilePaths; do
    for bucket in $1de/; do
        echo "This is the bucket: $bucket "
        p=$bucket$changedFile 
        echo THIS IS: "$p"
        echo "this is the changed file: " $changedFile
        gsutil cp $changedFile $p || continue
    done;
done;
