#!/bin/bash

source_file_1=$1
source_file_2=$2
source_dir=$3
dest_file=$4

declare -A patients
declare -A classes
declare -A datasets

while read patient filename class dataset; do
  patients["$filename"]+="$patient"
  classes["$filename"]+="$class"
  datasets["$filename"]+="$dataset"
done <"$source_file_1"

while read patient filename class dataset; do
  patients["$filename"]+="$patient"
  classes["$filename"]+="$class"
  datasets["$filename"]+="$dataset"
done <"$source_file_2"

for filename in $(find "$source_dir" -type f); do
  f="${filename##*/}"
  echo ${patients["$f"]} "$f" ${classes["$f"]} ${datasets["$f"]} >> "$dest_file"
done
