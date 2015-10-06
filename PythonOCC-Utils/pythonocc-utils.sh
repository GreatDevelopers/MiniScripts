#!/bin/sh

cd 

git clone https://github.com/tpaviot/pythonocc-utils.git

cd pythonocc-utils

python setup.py install

cp /usr/local/lib/python2.7/dist-packages/* /usr/lib/python2.7/dist-packages/
