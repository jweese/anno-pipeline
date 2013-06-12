#!/bin/bash
#$ -cwd
#$ -l mem_free=40g,h_rt=08:00:00,h_vmem=40g,num_proc=8
#$ -N annotate
#$ -S /bin/bash
#$ -V
#$ -m easb
#$ -M ferraro@cs.jhu.edu

# pipeline.sh
# author: Jonny Weese <jonny@cs.jhu.edu>
# edited: Frank Ferraro
#
# run Courtney's annotation pipeline on the cluster with the appropriate
# variables and resource requirements set up.

# die if any variables are unset
set -o nounset

: ${RECASER_PORT=9001}
: ${RUN_DIR=/home/hltcoe/fferraro/code/anno-pipeline/}

INPUT=$1
WORKDIR=$2
RECASER_HOST=$3
##RUN_DIR=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd)/

echo $0 $*

echo $RUN_DIR
shift 3;

# These environment variables need to be set appropriately to run the commands
# in the agiga pipeline. For now they are hard-coded to values that work on the
# COE cluster. These need to be changed if you will run the script somewhere
# else.
#
# PYTHONPATH for splitta
# PERL5LIB for HTML::Entities in the pipeline's merge.pl
env PYTHONPATH=/home/hltcoe/cnapoles/annotation/lib/splitta.1.03 \
    PERL5LIB=/home/hltcoe/cnapoles/lib/perl5:/home/hltcoe/cnapoles/lib/perl5/site_perl:/home/hltcoe/cnapoles/lib/perl5/site_perl/5.16.0/x86_64-linux-thread-multi-ld/ \
    RECASER_PORT=${RECASER_PORT} \
    DIR_TO_SINGLE_FILE="~/data/muc-process/muc4-to-gigadoc.sh" \
    ${RUN_DIR}/pipeline.sh $INPUT $WORKDIR $RECASER_HOST --qsub f $*
