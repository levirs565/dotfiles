#!/bin/sh
cd ~/.config/Code/Dictionaries

ln -fs /usr/share/hunspell/en_US.* .
ln -fs en_US.aff en.aff
ln -fs en_US.dic en.dic

ln -fs ~/.local/share/hunspell/id_ID.* .
ln -fs id_ID.aff id.aff
ln -fs id_ID.dic id.dic
