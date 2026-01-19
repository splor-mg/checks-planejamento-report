FROM rocker/r-ver:4.3.2

WORKDIR /project

RUN /rocker_scripts/install_pandoc.sh
RUN /rocker_scripts/install_python.sh

RUN export DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install -y git libcurl4-openssl-dev libssl-dev libxt6 libsodium-dev

COPY requirements.txt .
COPY DESCRIPTION .

RUN python3 -m pip install -r requirements.txt
RUN Rscript -e "install.packages('renv')" && Rscript -e 'renv::install()'
