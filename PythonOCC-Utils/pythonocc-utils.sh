#!/bin/sh

# Changing current directory to home directory 
cd 

# Download pythonocc-utils 
git clone https://github.com/tpaviot/pythonocc-utils.git

# Changing home directory to PythonOCC-Utils directory
cd pythonocc-utils

# Installing PythonOCC-Utils 
python setup.py install

cp -r /usr/local/lib/python2.7/dist-packages/OCCUtils /usr/lib/python2.7/dist-packages/
