reqchan:die() {
    echo "${0##*/}: ${FUNCNAME##*:}: ${@}"
    exit 1
}

reqchan:err() {
    echo "${0##*/}: ${FUNCNAME##*:}: ${@}"
    return 1
}

reqchan:info() {
    echo "${0##*/}: ${FUNCNAME##*:}: ${@}"
}

reqchan:success() {
    echo "${0##*/}: ${FUNCNAME##*:}: ${@}"
    return 0
}

check:die() {
    if ! "${status}" ; then
        echo "${0##*/}: ${FUNCNAME##*:}: ${@}"
        exit 1
    fi
}

reqchan:polkit() {
    if [[ -n "${@}" ]] ; then
        if command -v "sudo" &> /dev/null ; then
            sudo bash -c "${@}"
        elif command -v "doas" &> /dev/null ; then
            doas bash -c "${@}"
        else
            reqchan:err "There is no auth manager found!"
        fi
    fi
}

check:cmd() {
    local status="true" c=""
    for c in "${@}" ; do
        if ! command -v "${c}" &> /dev/null ; then
            echo -e "\t-> \"${c}\" ... not found!"
            local status="false"
        fi
    done

    if ! "${status}" ; then
        return 1
    fi
}