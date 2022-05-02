#!/bin/bash

path=$1
word=$2
recursive=$3



RemoveAllOUT()
{
for f in $path/*.out
do
   # if file, delete it
   [ -f "$f" ] && rm "$f"
done
CompileLib ./ $path
}


CompileLib()
{
for file in $path/*; 
do
if (grep -i -c -w $word $file>0)
then
 gcc "$file" -w -o $file.out
    fi

  done
}




if (($# >= 1))
then
	RemoveAllOUT $path $word $recursive
else
	echo "Not enough parameters"
fi
