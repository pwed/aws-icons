#!/bin/bash

ICON_ZIP_URL=$(curl -s https://aws.amazon.com/architecture/icons/ | grep -o 'https.*Asset-Package.*.zip')
ICON_ZIP_FILE="icons.zip"
ICON_FOLDER=lib
wget -q $ICON_ZIP_URL -O $ICON_ZIP_FILE

rm -rf $ICON_FOLDER
mkdir -p $ICON_FOLDER

unzip -qq $ICON_ZIP_FILE -d $ICON_FOLDER
rm $ICON_ZIP_FILE

cd $ICON_FOLDER

GROUP_FOLDER="Architecture-Group"
SERVICE_FOLDER="Architecture-Service"
CATEGORY_FOLDER="Category"
RESOURCE_FOLDER="Resource"

rm -rf __MACOSX
find -type f -regex ".*\.DS_Store" -exec rm {} \;

# Remove the date off of the folder names
for f in *; do
    mv $f "${f/-Icons_[0-9]*/}"
done

# Remove all PNG files
find -type f -regex ".*\.png" -exec rm {} \;

## Architecture Groups
for f in $GROUP_FOLDER/*; do
    mv "$f" "${f/_32/}"
done

## Architecture Services
for f in $SERVICE_FOLDER/*; do
    mv "$f" "${f/Arch_/}"
done

for f in $SERVICE_FOLDER/*/64/*; do
    mv "$f" "${f/\/64/}"
done

rm -rf $SERVICE_FOLDER/*/??

for f in $SERVICE_FOLDER/*/*; do
    mv "$f" "${f/Arch_/}"
done

for f in $SERVICE_FOLDER/*/*; do
    mv "$f" "${f/_64/}"
done

## Category
for f in $CATEGORY_FOLDER/Arch-Category_64/*; do
    mv "$f" "${f/\/Arch-Category_64/}"
done

rm -rf $CATEGORY_FOLDER/Arch-Category_??

for f in $CATEGORY_FOLDER/*; do
    mv "$f" "${f/_64/}"
done
for f in $CATEGORY_FOLDER/*; do
    mv "$f" "${f/Arch-Category_/}"
done

## Resource
for f in $RESOURCE_FOLDER/*; do
    mv "$f" "${f/Res_/}"
done

for f in $RESOURCE_FOLDER/*/*; do
    mv "$f" "${f/_48/}"
done

for f in $RESOURCE_FOLDER/General-Icons/*; do
    mv "$f" "${f/Res_/}"
done
for f in $RESOURCE_FOLDER/General-Icons/*/*; do
    mv "$f" "${f/Res_/}"
done
for f in $RESOURCE_FOLDER/General-Icons/*/*; do
    mv "$f" "${f/_48/}"
done
for f in $RESOURCE_FOLDER/General-Icons/Dark/*; do
    mv "$f" "${f/\/Dark/}"
done
for f in $RESOURCE_FOLDER/General-Icons/Light/*; do
    mv "$f" "${f/\/Light/}"
done
rm -rf $RESOURCE_FOLDER/General-Icons/Light $RESOURCE_FOLDER/General-Icons/Dark
for f in $RESOURCE_FOLDER/General-Icons/*.svg; do
    mv "$f" "${f/_/-}"
done
for f in $RESOURCE_FOLDER/*/Res_*.svg; do
    mv "$f" "${f/Res_/}"
done

for f in $RESOURCE_FOLDER/*/*\ .svg; do
    mv "$f" "${f// /}"
done

for f in $RESOURCE_FOLDER/*/*_*.svg; do
    readarray -d _ -t FOLDER_NAME <<<"$f"
    mkdir -p $FOLDER_NAME
    mv $f "${f/_/\/}"
done

mv $GROUP_FOLDER Groups
mv $SERVICE_FOLDER Services
mv $CATEGORY_FOLDER Categories
mv $RESOURCE_FOLDER Resources
