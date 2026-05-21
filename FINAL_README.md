## Members
- Verrengia Alessandro
- Sironi Vittorio
- Pinelli Gaia Bianca
- Buttini Nicolò

## AstraLog-HPC: Standard Track Implementation

This repository contains the CI/CD pipeline and containerization logic for the AstraLog-HPC reference implementation. 

## Work Distribution
- Class Diagram: Buttini (18h)
- Use Cases: Buttini (6h)
- Sequence Diagram: Buttini (2h)
- Domain Assumptions: Verrengia
- Requirements: Verrengia
- CI/CD Pipeline: Sironi
- Containerization: Verrengia
- HPC Execution: Pinelli
- Automation: Pinelli

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
