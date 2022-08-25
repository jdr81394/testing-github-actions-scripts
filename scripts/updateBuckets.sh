#!/bin/bash

#  Run step for all changed translation files files and put into Github Env

initialChangedFiles=$( echo $@ )

englishFilePaths=()


for file in $initialChangedFiles; do
    if [[ ${file:0:18} == "public/locales/en/" ]]; then
        englishFilePaths+=("${file:18}")
    fi;
done

cd public/locales/en/ 

for changedFile in ${englishFilePaths[@]}; do
    p=$1en/$changedFile 
    gsutil cp $changedFile $p || continue
done;

cd ../../../

germanFilePaths=()

for file in $initialChangedFiles; do
    if [[ ${file:0:18} == "public/locales/de/" ]]; then
        germanFilePaths+=("${file:18}")
    fi;
done

cd public/locales/de/ 

for changedFile in ${germanFilePaths[@]}; do
    p=$1de/$changedFile 
    gsutil cp $changedFile $p || continue
done;
