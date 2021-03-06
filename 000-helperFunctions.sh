#! /bin/bash

function helperCheckScriptRequirements(){
    local __requirements=("az" "jq" "kubectl")

    for __req in ${__requirements[@]}; do
        local __results=$(which $__req)

        if [ $? -eq 0 ]
        then
            echo "SUCCESS Requirement: $__req found."
        else
            echo "FAILED Requirement: $__req not found.  Please install '$__req'." > err.log
            return 1
        fi
    done
}

# Function for comparing versions.
function helperCheckSemVer() {
    echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4) }'
}

# Function clear previous files
function helperClearTempFiles() {
    rm -rf $TEMP_FOLDER
    mkdir -p $TEMP_FOLDER
}