#!/bin/bash 

IFS='.' read -r fileName type <<< $1

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
    esac
}

function execute {
    case $type in 
        "java") command="java $fileName" ;;
        "js") command="node $fileName" ;; 
        "cpp") command=./a.out ;;
        "py") command="./$fileName.$type" ;;  
    esac
    if [ $1 = true ]; then  
        inputFromFile $1 
        $command < input.txt > out.txt
    else 
        inputFromFile $1 
        $command
    fi
}

flags=$2
compile $1 # compile files  

if [ -z "$flags" ]; then 
    execute false  # if execute function is called file will be executed true or false is for reading input from file or not
    deleteFiles true
elif [[ ${flags:0:1} == "-" ]]; then
    delete=true
    for (( i=1; i<${#flags}; i++ )); do
        flag=${flags:$i:1}
        case $flag in 
            "f") execute true ;; 
            "d") delete=false ;;
        esac 
    done 
    if [ $delete = true ]; then  
        deleteFiles true
    else 
        deleteFiles false
    fi
else
    echo -e  "\e[32mInvalid arguments\e[0m"
fi



