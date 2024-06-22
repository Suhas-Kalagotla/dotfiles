#!/bin/bash 

IFS='.' read -r fileName type <<< $1

function input {
    case $1 in 
        1) 
            echo -e  "\e[32mEnter Input\e[0m"
            ;;
        2) 
            echo -e "\e[32mInput read from file\e[0m"
            ;;
    esac 
}


function delete(){
    case $1 in 
        1)
            rm -f *.class
            ;;
        2)
            rm -f *.out
            ;;
    esac
}


if [ "$type" = "java" ]; then   # java 
    javac $1 && 
    if [ "$2" = "-f" ]; then 
        input 2
        java $fileName < input.txt > out.txt
    else 
        input 1
        java $fileName
    fi
    if [ "$2" != "-d" ]; then 
        delete 1
    fi

elif [ "$type" = "cpp" ]; then # c++
    g++ $1 -o "$fileName.out" && 
    if [ "$2" = "-f" ]; then 
        input 2
        "./$fileName.out" < input.txt > out.txt 
    else 
        input 1 
        "./$fileName.out"  
    fi
    if [ "$2" != "-d" ]; then 
        delete 2
    fi

elif [ "$type" = "py" ]; then  # python 
    chmod +x $1 && 
    if [ "$2" = "-f" ]; then 
        input 2 
        ./$1 < input.txt > out.txt
    else
        input 1
        ./$1
    fi
elif [ "$type" = "js" ]; then  # javascript
    if [ "$2" = "-f" ]; then 
        input 2 
        node $1 < input.txt > out.txt
    fi
else 
    echo "File Type not known"
fi

