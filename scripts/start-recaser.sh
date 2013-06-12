#!/bin/bash

export JOSHUA="${HOME}/code/joshua-v5.0rc3/"
: ${RECASER="/export/common/SCALE13/Text/narrative/en-recaser/"}
: ${RECASER_THREADS=1}
: ${RECASER_PORT=5698}

rcmd="$RECASER/run-joshua.sh -server-port ${RECASER_PORT} -threads $RECASER_THREADS "
export RECASER_SERVER_UP="$(hostname):${RECASER_PORT}"
echo $RECASER_SERVER_UP
echo $rcmd
eval "$rcmd"


