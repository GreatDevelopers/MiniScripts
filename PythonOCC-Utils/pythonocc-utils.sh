#!/bin/sh

# Changing current directory to home directory 
cd 

# Installing pythonocc-utils 
git clone https://github.com/tpaviot/pythonocc-utils.git

# Changing home directory to PythonOCC-Utils directory
cd pythonocc-utils

# Installing PythonOCC-Utils 
python setup.py install

cp /usr/local/lib/python2.7/dist-packages/* /usr/lib/python2.7/dist-packages/
