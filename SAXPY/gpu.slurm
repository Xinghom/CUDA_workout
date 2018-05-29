#!/bin/bash -l

### job name
#SBATCH -J gpu

### job queue
#SBATCH -p 96x24gpu4

### request 1 Nvidia-P100 GPU
#SBATCH --gres=gpu:p100:1

### request 24GB host MEM
#SBATCH --mem=24000

### request 1hour walltime
#SBATCH -t 1:00:00

### Ask SLURM to send emial, when jobs aborts, starts, and ends/
###SBATCH --mail-user=xxu60@ucsc.edu
###SBATCH --mail-type=All

module load cuda
./saxpy
