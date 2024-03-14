# FROM ubuntu:24.04
FROM nvidia/cuda:12.3.1-runtime-ubuntu22.04
ENV PATH="/root/anaconda3/bin:${PATH}"
ARG PATH="/root/anaconda3/bin:${PATH}"

RUN apt update \
    && apt install -y python3-dev wget

RUN wget https://repo.anaconda.com/archive/Anaconda3-2023.09-0-Linux-x86_64.sh \
    && mkdir root/.conda \
    && sh Anaconda3-2023.09-0-Linux-x86_64.sh -b \
    && rm -f Anaconda3-2023.09-0-Linux-x86_64.sh

COPY ./environment.yml /

RUN conda env create -f /environment.yml \
    && conda init bash \
    && echo "conda activate ece60146" >> ~/.bashrc \
    && conda install -n ece60146 ipykernel \
    && /root/anaconda3/envs/ece60146/bin/ipython kernel install --user --name=ece60146

CMD ["/bin/bash"]