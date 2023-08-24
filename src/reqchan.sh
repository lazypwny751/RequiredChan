#!/bin/bash

set -e
shopt -s expand_aliases

# Define pre-variables.
export status="true" PREFIX="/usr/share" OPT="help" OPTARG=()
export SRCDIR="${PREFIX}/RequiredChan"
export rcmd=(
    "sqlite3"
    "chmod"
    "uname"
    "mkdir"
    "git"
    "cp"
    "rm"
    "ln"
)

require:lib() {
    local FOUND=() status="true"
    for f in "${@}" ; do
        if [[ -f "${SRCDIR}/lib/${f}.sh" ]] ; then
            local FOUND+=("${SRCDIR}/lib/${f}.sh")
        elif [[ -f "${SRCDIR}/lib/${f}" ]] ; then
            local FOUND+=("${SRCDIR}/lib/${f}")
        else
            echo "${0##*/}: There is no file found as \"${f}\"!"
            local status="false"
        fi
    done

    if "${status}" ; then
        for s in "${FOUND[@]}" ; do
            source "${s}"
        done
        return 0
    else
        return 1
    fi
}

require:lib "color" "corelib" || {
    echo "${0##*/}: fatal: Couldn't sourced that required libraries."
    exit 1
}

check:cmd "${rcmd[@]}" || {
    reqchan:die "Missing dependencies, please install them before execute the ${0##*/}."
}

## Parsing parameters..
while [[ "${#}" -gt 0 ]] ; do
    case "${1}" in
        "--"[hH][eE][lL][pP]|"-"[hH])
            export OPT="help"
            shift
        ;;
        *)
            export OPTARG+=("${1}")
            shift
        ;;
    esac
done

case "${OPT}" in
    "help")
        echo -e "There is X option: 

"
    ;;
    *)
        reqchan:die "There is no option like \"${OPT}\"."
    ;;
esac