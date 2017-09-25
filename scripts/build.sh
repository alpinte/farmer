#/bin/sh

ROOT="$(cd $(dirname $(readlink -f $0))/.. &&  pwd)"

DIRS=""
if test -n "$*";
then
    for D in "$*";
    do
        F="$ROOT/app/$D/build.sh"

        if test -e "$F";
        then
            DIRS="$DIRS $F"
        else
            echo $F doesnot exists
        fi
    done
else
    DIRS=$(echo $ROOT/app/*/build.sh)
fi


for I in $DIRS;
do
    D=$( dirname $I )
    echo build $D
    docker run -ti -v $D:/tmp/run -v $ROOT/bin:/tmp/out farmer-builder /tmp/run/build.sh
done

