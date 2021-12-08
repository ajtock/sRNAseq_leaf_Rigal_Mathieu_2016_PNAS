#!/bin/bash

# Download raw paired-end fastq.gz files

# filereport_read_run_PRJNA349052_tsv_full.txt downloaded from
# https://www.ebi.ac.uk/ena/browser/view/PRJEB9919

# Usage
# ./1_awk_download_list.sh PRJEB9919

accession=$1

awk 'FS="\t", OFS="\t" {print $2, $3, $4}' "filereport_read_run_"$accession"_tsv.txt" > $accession".txt"
awk 'FS="\t", OFS="\t" { gsub("ftp.sra.ebi.ac.uk", "era-fasp@fasp.sra.ebi.ac.uk:"); print }' $accession".txt" \
| cut -f 3 \
| awk -F ";" 'OFS="\n" {print $1, $2}' \
| awk NF \
| awk 'NR > 1, OFS="\n" { print "ascp -QT -l 300m -P33001 -i /home/ajt200/.aspera/connect/etc/asperaweb_id_dsa.openssh" " " $1 " ."}' \
> $accession"_download.txt"
