#!/bin/bash

source activate sRNAseq_mapping
snakemake -p --cores 48
source deactivate
