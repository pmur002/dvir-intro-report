
# Base image
FROM ubuntu:16.04
MAINTAINER Paul Murrell <paul@stat.auckland.ac.nz>

# add CRAN PPA
RUN apt-get update && apt-get install -y apt-transport-https
RUN echo 'deb https://cloud.r-project.org/bin/linux/ubuntu xenial/' > /etc/apt/sources.list.d/cran.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

# Install additional software
# R stuff
RUN apt-get update && apt-get install -y \
    xsltproc \
    r-base=3.5* \ 
    libxml2-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    bibtex2html \
    subversion 

# For building the report
RUN Rscript -e 'install.packages(c("knitr", "devtools"), repos="https://cran.rstudio.com/")'
RUN Rscript -e 'library(devtools); install_version("xml2", "1.1.1", repos="https://cran.rstudio.com/")'
RUN apt-get install -y imagemagick

# Packages used in the report
RUN Rscript -e 'library(devtools); install_version("extrafont", "0.17", repos="https://cran.rstudio.com/")'
RUN Rscript -e 'library(devtools); install_version("fontcm", "1.1", repos="https://cran.rstudio.com/")'
RUN Rscript -e 'library(devtools); install_version("tikzDevice", "0.12", repos="https://cran.rstudio.com/")'

# The main report package(s)
RUN Rscript -e 'library(devtools); install_github("pmur002/gdtools@v0.1.7.9001")RUN Rscript -e 'library(devtools); install_github("pmur002/dvir@v0.1-0")'


