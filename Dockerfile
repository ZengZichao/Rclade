FROM rocker/r-ver:4.5.3

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install R package dependencies from CRAN and Bioconductor
RUN R -e ' \
    install.packages(c("ape", "ggplot2", "rlang", "stringr", "viridisLite", "optparse", "yaml"), \
                     repos="https://cloud.r-project.org"); \
    if (!requireNamespace("BiocManager", quietly=TRUE)) \
        install.packages("BiocManager", repos="https://cloud.r-project.org"); \
    BiocManager::install(c("ggtree", "treeio"), ask=FALSE, update=FALSE); \
    install.packages(c("deeptime", "tidytree"), repos="https://cloud.r-project.org") \
'

# Install Rclade from the source tree (no pre-built tarball required).
# Build the image from the package root:  docker build -t rclade .
COPY . /tmp/Rclade-src
RUN R CMD INSTALL /tmp/Rclade-src

# Verify installation
RUN Rscript -e 'library(Rclade); q(status = run_rclade_selftest())'

WORKDIR /data

# Propagate Rclade's documented Unix exit codes (0/1/2/3/130) to the
# container process: run_rclade_cli() returns the exit code as an integer,
# which q(status = ...) forwards to the OS.  For correct SIGINT (Ctrl+C)
# propagation to exit code 130, docker run needs --init (tini as PID 1).
ENTRYPOINT ["Rscript", "-e", "q(status = Rclade::run_rclade_cli(commandArgs(trailingOnly = TRUE)))"]
CMD ["--help"]
