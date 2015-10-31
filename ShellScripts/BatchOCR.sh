#!/bin/bash

: 'This script can be used to create .txt files from the images within the directory. In this example of script, the input is taken as all png images. And set the value of count to a starting image number from where you want to start.'

# The -v option is natural sort of (version) numbers within text

ls -v *.png>pics;
let count=1

: 'The following while loop will iterate through the file pics created above line by line till end of file and execute the tesseract command.'

while read line;
do tesseract $line $count.txt -l eng;
((count++));
done<pics
