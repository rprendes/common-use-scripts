#!/bin/bash
#SBATCH --job-name=checksum
#SBATCH --time=30-0
#SBATCH --mem=1000
#SBATCH --cpus-per-task=20
#SBATCH --output=output_check_%j.txt
#SBATCH --error=error_output_wtdbg2_check_%j.txt


find . -type d | parallel --jobs 20  'cd {}; md5sum -c MD5.txt > results' 
