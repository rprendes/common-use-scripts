#!/bin/bash
#SBATCH --job-name=stats
#SBATCH --time=7-0
#SBATCH --mem=100000
#SBATCH --cpus-per-task=20
#SBATCH --output=output_stat_%j.txt
#SBATCH --error=error_output_stats_%j.txt

#statistis from assembly script_stats.sh file.fa out_folder

module load perl/gcc/64/5.26.1
#statistis from assembly script_quast file.fa out_folder
module load java/jre/1.8.0/144
module load samtools/gcc/64/1.9
module load bedtools
module load java/jre/1.8.0/144


quast $1 --threads 20 -o o$2