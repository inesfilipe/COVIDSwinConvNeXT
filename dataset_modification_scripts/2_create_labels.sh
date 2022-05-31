#!/bin/bash

source_file=$1
dest_file=$2

while read patient filename class dataset; do

  if [ "$class" = "positive" ]; then
    class="COVID-19"
  fi

  echo "$patient $filename $class $dataset" >> "$dest_file"
done <"$source_file"
