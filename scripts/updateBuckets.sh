#!/bin/bash

#  Run step for all changed translation files files and put into Github Env

initialChangedFiles=$( echo $@ )

echo "initially changed files " $initialChangedFiles

englishFilePaths=()


for file in $initialChangedFiles; do
    echo "This is the file: " $file
    if [[ ${file:0:18} == "public/locales/en/" ]]; then
        echo " adding to english path: " ${file:18}
        englishFilePaths+=("${file:18}")
    fi;
done

echo "This is the english files path: $englishFilePaths"
echo "first argument: $1"

# Get rid of the first value because it is going to be the parent directory of en/ede

#  Loop through the GCP buckets, and add the files

cd public/locales/en/ 

for changedFile in $englishFilePaths; do
    p=$1en/$changedFile 
    echo THIS IS: "$p"
    echo "this is the changed file: " $changedFile
    gsutil cp $changedFile $p || continue
done;

cd ../../../

germanFilePaths=()

for file in $initialChangedFiles; do
    echo "File again: $file"
    if [[ ${file:0:18} == "public/locales/de/" ]]; then
        germanFilePaths+=(${file:18})
    fi;
done

cd public/locales/de/ 

for changedFile in $germanFilePaths; do
    p=$1de/$changedFile 
    echo THIS IS: "$p"
    echo "this is the changed file: " $changedFile
    gsutil cp $changedFile $p || continue
done;
