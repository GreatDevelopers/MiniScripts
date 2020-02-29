#!/bin/bash
IFS=","
while read k1 doverA
do
        echo "K1: $k1","doverA: $doverA"
done < csvFile.csv

