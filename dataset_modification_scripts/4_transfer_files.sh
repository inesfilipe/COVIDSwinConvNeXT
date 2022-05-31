#!/bin/bash

source_file=$1
source_dir=$2
dest_dir=$3

declare -A images

datasets=("cohen" "ricord" "rnsa" "rsna")
classes=("COVID-19" "pneumonia" "normal")

for dataset in ${datasets[@]}; do
  for class in ${classes[@]}; do
    images[$dataset'_'$class]=0
  done
done

while read patient filename class dataset; do
  if [ "$dataset" = "cohen" ] || [ "$dataset" = "ricord" ] || [ "$dataset" = "rnsa" ]; then
    ((images["$dataset"_"$class"]++))
    mv "$source_dir"/"$class"/"$filename" "$dest_dir"/"$class"/
  elif [ "$dataset" = "rsna" -a "$class" = "pneumonia" -a $((images["$dataset"_"$class"])) -lt 700 ]; then
    ((images["$dataset"_"$class"]++))
    mv "$source_dir"/"$class"/"$filename" "$dest_dir"/"$class"/
  elif [ "$dataset" = "rsna" -a "$class" = "normal" -a $((images["$dataset"_"$class"])) -lt 800 ]; then
    ((images["$dataset"_"$class"]++))
    mv "$source_dir"/"$class"/"$filename" "$dest_dir"/"$class"/
  fi
done <"$source_file"

for key in "${!images[@]}"; do
  if [ $((images["$key"])) -gt 0 ]; then
    echo "transfer to test" "$key" ${images["$key"]}
  fi
done
