#!/bin/bash
#SBATCH --job-name=astralog_mock
#SBATCH --partition=g100_usr_prod
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --time=00:10:00
#SBATCH --output=job_out_%j.txt
#SBATCH --error=job_err_%j.txt

# Carica il modulo per singularity (o apptainer) su Galileo 100
module load singularity

# Crea cartella di output
mkdir -p output_data

# Esecuzione del container
srun singularity run app_container.sif \
    --rules input/rules.json \
    --input input/telemetry_cleaned.csv \
    --output output_data
