#!/bin/bash

source_dir=$1
source_file=$2
dest_dir=$3

mkdir -p $dest_dir
while read p; do
  filename=$(echo "$p" | awk '{print $2}')
  mv "$source_dir"/"$filename" "$dest_dir"/"$filename"
done <"$source_file"
