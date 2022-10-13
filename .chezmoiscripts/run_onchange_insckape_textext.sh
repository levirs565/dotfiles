#!/bin/sh

echo Installing TexText plugin for inkscape

version=1.8.2
filename=TexText-Linux-${version}

wget -q https://github.com/textext/textext/releases/download/${version}/${filename}.zip

unzip ${filename}.zip -d ${filename}
rm ${filename}.zip

cd ${filename}/*
python3 setup.py

cd ../../
rm -rf ${filename}