#!/bin/bash 

IFS='.' read -r fileName type <<< $1

if [ "$type" = "java" ]; then 
    javac $1 && java $fileName
elif [ "$type" = "cpp" ]; then 
    g++ $1 && ./a.out
else 
    echo "File Type not known"
fi

