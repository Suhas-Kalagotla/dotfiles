#!/bin/bash 

fileName="${1%.*}"
type="${1##*.}"

function inputFromFile() {
    if [ $1 = true ]; then
        echo -e "\e[32mInput read from file\e[0m"
    else 
        echo -e  "\e[32mEnter Input\e[0m"
    fi
}


function deleteFiles {
    if [ $1 = true ] ; then 
        case $type in 
            "java")
                rm -f *.class
                ;;
            "cpp")
                rm -f *.out
                ;;
        esac
    fi
}

function compile {
    case $type in 
        "java") javac $1 ;;
        #"js") node $1 ;;
        "cpp") g++ $1 ;;
        "py") chmod +x $1 ;;  
        *) echo -e  "\e[32m .$type Invalid file type\e[0m" ;exit 1 ;; 
    esac
}

function execute {
    command=""
    if [ $2 = true ]; then 
        command+="time -p "
    fi
    inputFromFile $1 
    case $type in 
        "java") command+="java $fileName" ;;
        "js") command+="node $fileName" ;; 
        "cpp") command+=./a.out ;;
        "py") command+="./$fileName.$type" ;;  
    esac
    if [ $1 = true ]; then  
       $command < input.txt > out.txt
    else 
        $command
    fi
}

flags=$2
compile $1 # compile files  

if [ -z "$flags" ]; then 
    execute false false  # it expects two parameters "reading from file" and "to use time command or not"
    deleteFiles true
elif [[ ${flags:0:1} == "-" ]]; then
    delete=true
    fileRead=false
    timeprint=false

    for (( i=1; i<${#flags}; i++ )); do
        flag=${flags:$i:1}
        case $flag in 
            "t") timeprint=true ;;
            "f") fileRead=true ;; 
            "d") delete=false ;;
            *) echo -e  "\e[32mInvalid flag: $flag\e[0m" ; exit 1;;
        esac 
    done 
    execute $fileRead $timeprint
    deleteFiles $delete
else
    echo -e  "\e[32mInvalid arguments\e[0m"
fi



