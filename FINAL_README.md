## AstraLog-HPC: Standard Track Implementation

This repository contains the CI/CD pipeline and containerization logic for the AstraLog-HPC reference implementation. 

### Continuous Integration (CI) Pipeline
The CI/CD pipeline is implemented using GitHub Actions and is defined in `.github/workflows/main.yaml`. 

**Current Pipeline Workflow:**
1.  **Trigger:** The pipeline executes automatically upon every push to the `main` branch.
2.  **Environment:** The job runs on an `ubuntu-latest` runner.
3.  **Setup:** It checks out the repository code and initializes a Python 3.10 environment.
4.  **Dependencies:** It upgrades `pip` and installs the required packages listed in `requirements.txt`.
5.  **Testing:** It executes the test suite using `pytest -v` to ensure the codebase remains stable and passes all predefined checks.

### Containerization Strategy
To ensure reproducible execution on HPC environments like the Galileo100 cluster, the AstraLog-HPC application has been containerized using Singularity. The container definition file bootstraps from a minimal Python 3.10 Docker image (`python:3.10-slim`).

**Container Build Steps:**
* **Source Copying:** The `src/` directory and `requirements.txt` are injected into the container's `/app` directory.
* **Environment Configuration:** The `%post` block updates the system packages, installs necessary build tools, and installs the Python requirements via `pip`.
* **Execution Setup:** The `PYTHONPATH` is explicitly set to `/app/src` in the `%environment` block to ensure all internal module imports resolve correctly.
* **Runscript:** Executing the container directly (`singularity run`) triggers the `astralog_mock.py` script, forwarding any provided command-line arguments to the application.

### Next Steps for Full Automation
As part of the ongoing Step 1 and Step 2 phases of the project, this pipeline will be extended to:
1.  Automatically build the Singularity container image (`.sif`) directly within the GitHub Actions runner.
2.  Securely transfer the container and a `job.sh` submission script to the Galileo100 cluster using GitHub Secrets.
3.  Automate the execution of the application on the cluster via the SLURM job scheduler and retrieve the standard output/error files back into the repository.
