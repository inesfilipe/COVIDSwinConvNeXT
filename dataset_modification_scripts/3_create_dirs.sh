#!/bin/bash

source_dir=$1
source_file=$2
dest_dir=$3

mkdir -p "$dest_dir"
while read patient filename class dataset; do
  mkdir -p "$dest_dir"/"$class"
  mv "$source_dir"/"$filename" "$dest_dir"/"$class"/"$filename"
done <"$source_file"
