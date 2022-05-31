#!/bin/bash

source_file=$1

for dataset in $(cat $source_file | awk '{print $4}' | sort | uniq); do
  echo $dataset;
  echo $(cat $source_file | grep $dataset | awk '{print $3}' | sort | uniq -c);
done
