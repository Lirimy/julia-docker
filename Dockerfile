FROM jupyter/base-notebook

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libxt6 \
    libxrender1 \
    libgl1-mesa-glx \
    imagemagick \
    ffmpeg && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV JULIA_VERSION=0.6.3

RUN mkdir /opt/julia-${JULIA_VERSION} && \
    cd /tmp && \
    wget -q https://julialang-s3.julialang.org/bin/linux/x64/0.6/julia-0.6.3-linux-x86_64.tar.gz && \
    tar xzf julia-${JULIA_VERSION}-linux-x86_64.tar.gz -C /opt/julia-${JULIA_VERSION} --strip-components=1 && \
    rm /tmp/julia-${JULIA_VERSION}-linux-x86_64.tar.gz
RUN ln -fs /opt/julia-${JULIA_VERSION}/bin/julia /usr/local/bin/julia

USER $NB_UID

ENV CONDA_JL_VERSION=3
ENV PYTHON=''
ENV GRDIR=''

RUN julia -e 'Pkg.init()' && \
    julia -e 'Pkg.update()' && \
    julia -e 'Pkg.add("IJulia")' && \
    julia -e 'Pkg.add("Plots")' && \
    julia -e 'Pkg.add("PyPlot")' && \
    julia -e 'using GR' && \
    julia -e 'using Plots' && \
    julia -e 'using PyPlot'

RUN mkdir -p /home/jovyan/.jupyter/custom
COPY custom.css /home/jovyan/.jupyter/custom/
