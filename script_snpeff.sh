#!/bin/bash
#SBATCH --job-name=snpeff
#SBATCH --time=1-0
#SBATCH --mem=1000
#SBATCH --cpus-per-task=5
#SBATCH --output=output_snpeff%j.txt
#SBATCH --error=error_snpeff%j.txt
set -e

start=`date +%s`

module load java/jdk/1.8.0/202
module load bcftools

## files in folder 
pop.Info.txt ## population info
var_FILE.vcf ## vcf files
bos_taurus_incl_consequences.vcf.gz ## file with annotation


## zip and index large files 

bgzip -c var_FILE.vcf > var_FILE.vcf.gz
tabix -p var_FILE_eff.vcf.gz


## create vars

snpeff=/home/snpEff/
vcf=var_FILE_eff.vcf ## vcf file without .gz

## remove not biallelic 
bcftools view --threads 5 -m2 -M2 $vcf | bgzip -c > bi_${vcf};tabix -p vcf bi_${vcf}.gz

# effect prediction and annotation
java -Xmx20G -jar $snpeff/snpEff.jar eff ARS-UCD1.2.99 bi_${vcf}.gz |\
bcftools annotate -a bos_taurus_incl_consequences.vcf.gz -c ID |  bgzip -c > bi_${vcf}_annotated_eff.vcf



end=`date +%s`
runtime=$((end-start))
