#!/bin/bash
# build.sh


function usage() {
echo "
    To build jade:
    ./build.sh --jade

    To build jade with compress:
    ./build.sh --jade --jade-compress

    To build stylus:
    ./build.sh --stylus

    To build stylus with compress:
    ./build.sh --stylus --stylus-compress

    To build script:
    ./build.sh --script

    To build script with compress:
    ./build.sh --script --script-compress

    To build script with sourcemap:
    ./build.sh --script --script-sourcemap

    To build all:
    ./build.sh --all

    To build all with compress:
    ./build.sh --all --all-compress
"
}


# Empty arguments
if [[ -z "$1" ]]; then
    usage;
    exit 1;
fi


# Parse arguments
while [[ $# > 0 ]]; do
    key="$1"

    case $key in
        --jade)
            __jade=true
            ;;

        --jade-compress)
            __jade_compress=true
            ;;

        --stylus)
            __stylus=true
            ;;

        --stylus-compress)
            __stylus_compress=true
            ;;

        --script)
            __script=true
            ;;

        --script-compress)
            __script_compress=true
            ;;

        --script-sourcemap)
            __script_sourcemap=true
            ;;

        --all)
            __all=true
            ;;

        -h|--help)
            usage;
            exit 1;
            ;;

        *)
            usage;
            echo "  [error] unknown option:" $key;
            exit 1;
            ;;
    esac

    shift;
done


# Build jade
if [[ $__jade ]]; then
    echo "  build jade"
    jade --out ./new-project/ ./new-project-src/*.jade
fi


# Build stylus
if [[ $__stylus ]]; then
    echo "  build stylus"
    stylus --compress --out ./new-project/ ./new-project-src/*.styl
fi


# Build script
if [[ $__script ]]; then
    echo "  build script"

    # Compress script
    if [[ $__script_compress ]]; then
        echo "  build script with compress"
    fi

    # Create sourcemap of script
    if [[ $__script_sourcemap ]]; then
        echo "  build script with sourcemap"
    fi
fi


# Build all
if [[ $__all ]]; then
    ./build.sh --jade --jade-compress
    ./build.sh --stylus --stylus-compress
    ./build.sh --script --script-compress --script-sourcemap
fi

