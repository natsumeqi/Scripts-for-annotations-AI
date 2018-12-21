#! /bin/bash
#find files by name


TARGETDI="/....../"


echo "Enter the ID that you want to search:"
read id

echo  `find $TARGETDI -name "$id.txt"`               



