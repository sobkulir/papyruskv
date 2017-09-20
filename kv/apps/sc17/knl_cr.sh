#!/bin/bash -l

#SBATCH -J cr
#SBATCH -o output.o%j
#SBATCH -e output.e%j
#SBATCH -p normal
#SBATCH -N 64
#SBATCH -n 4352
#SBATCH -t 01:00:00
#SBATCH -A ##-#########

KEYLEN=16
VALLEN=131072
COUNT=1000
ANKS=(320)
RANKS=(68 136 272 544 1088 2176 4352)

export PAPYRUSKV_REPOSITORY=/tmp/pkv_cr
export PAPYRUSKV_LUSTRE=$SCRATCH/pkv_cr
export PAPYRUSKV_DESTROY_REPOSITORY=1

export PAPYRUSKV_GROUP_SIZE=1
export PAPYRUSKV_CONSISTENCY=2
export PAPYRUSKV_SSTABLE=1
export PAPYRUSKV_CACHE_LOCAL=0
export PAPYRUSKV_CACHE_REMOTE=0
export PAPYRUSKV_BLOOM=1

for i in "${RANKS[@]}"; do
    ibrun -np $i ./cr $KEYLEN $VALLEN $COUNT $PAPYRUSKV_LUSTRE c
export PAPYRUSKV_FORCE_REDISTRIBUTE=0
    ibrun -np $i ./cr $KEYLEN $VALLEN $COUNT $PAPYRUSKV_LUSTRE r
export PAPYRUSKV_FORCE_REDISTRIBUTE=1
    ibrun -np $i ./cr $KEYLEN $VALLEN $COUNT $PAPYRUSKV_LUSTRE r
    rm -rf $PAPYRUSKV_LUSTRE
done
