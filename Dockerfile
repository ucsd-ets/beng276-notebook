FROM ghcr.io/ucsd-ets/datascience-notebook:2025.1-stable

USER root

# Create the beng276 conda environment
ARG ENVNAME=beng276
ARG PYVER=3.11
RUN mamba create --yes -p "${CONDA_DIR}/envs/${ENVNAME}" \
    python=${PYVER} \
    ipykernel \
    pip && \
    "${CONDA_DIR}/envs/${ENVNAME}/bin/python" -m ipykernel install --prefix /opt/conda --name="${ENVNAME}"
    # jupyterlab && \
    # mamba clean --all -f -y && \
# RUN mamba create --yes -p 

# pdb2pqr
# https://pdb2pqr.readthedocs.io/en/latest/getting.html#python-package-installer-pip
RUN conda run -n ${ENVNAME} pip install pdb2pqr
#    pip install pdb2pqr

# apbs
# https://apbs.readthedocs.io/en/latest/getting/index.html#installing-from-pre-compiled-binaries
# https://github.com/Electrostatics/apbs/releases
# 3.4.1 Website 
ARG APBS_VERSION=3.4.1

RUN pwd && \
    cd /opt && \
    wget https://github.com/Electrostatics/apbs/releases/download/v$APBS_VERSION/APBS-$APBS_VERSION.Linux.zip && \
    unzip APBS-$APBS_VERSION.Linux.zip && \
    mv APBS-$APBS_VERSION.Linux apbs && \
    chown -R $NB_UID apbs && \
    rm APBS-$APBS_VERSION.Linux.zip

env PATH=/opt/apbs/bin:$PATH
env PATH=/opt/apbs/share/apbs/tools/bin:$PATH

# browndye2
ARG BROWNDYE_VERSION=browndye2-ubuntu-22.04-2023-12-30

# https://browndye.ucsd.edu/download.html#gnu-linux
RUN apt-get update -y && \
    apt-get install -y ocaml libexpat-dev liblapack-dev && \
    apt-get install -y libexpat1 make && \
    cd /opt && \
    wget https://browndye.ucsd.edu/downloads/$BROWNDYE_VERSION.tar.gz && \
    tar zxvf $BROWNDYE_VERSION.tar.gz && \
    chown -R $NB_UID browndye2 && \
    conda init bash && \
    exec bash && \
    rm $BROWNDYE_VERSION.tar.gz

env PATH=/opt/browndye2/bin:$PATH

# mdtraj
RUN mamba install -n ${ENVNAME} -y -c conda-forge openmm cudatoolkit=11.2
RUN mamba install -n ${ENVNAME} -y seekr2_openmm_plugin
RUN conda run -n ${ENVNAME} pip install mdtraj

# seekr2
RUN pwd && \
    apt-get install -y zlib1g-dev && \
    cd /opt && \
    git clone https://github.com/seekrcentral/seekr2.git && \
    cd seekr2 && \
    conda run -n ${ENVNAME} python -m pip install . 


# fenics
RUN mamba install -y -n ${ENVNAME} -c conda-forge fenics-dolfinx mpich pyvista

# RUN pwd
# COPY beng276.yml beng276.yml
# RUN ls -l ~ && \
#     cat beng276.yml && \
#     mamba env create --name beng276 --file beng276.yml

USER $NB_UID
