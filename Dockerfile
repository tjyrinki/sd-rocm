# Latest as of 2023-02-01
FROM rocm/pytorch:rocm5.4.1_ubuntu20.04_py3.7_pytorch_1.12.1

ENV DEBIAN_FRONTEND noninteractive
RUN apt update && apt -y upgrade

WORKDIR /webui

# Set to 10.3.0 for RDNA2 GPU support (treat card as Navi 21 generation)
# Set to 9.0.0 for GCN5 (Vega) generation
ARG HSA_OVERRIDE_GFX_VERSION

RUN pip3 install --upgrade pip
RUN conda update --name base --channel defaults --yes conda

RUN git clone https://github.com/invoke-ai/InvokeAI.git .
# A tested 2023-02-01 commit
RUN git checkout 5f16148dea45cf42f4e637d802dd1261a436f8b0

RUN cp -a environments-and-requirements/environment-lin-amd.yml ./environment.yml
RUN conda env create -f environment.yml
RUN cp -a environments-and-requirements/requirements-lin-amd.txt ./requirements.txt
RUN conda run --name invokeai pip3 install -r requirements.txt
# Latest pytorch ROCm version as of 2023-02-01
RUN conda run --name invokeai pip3 install --upgrade torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/rocm5.2

RUN mkdir -p /root/invokeai/outputs

ENTRYPOINT ["conda", "run", "-n", "invokeai", "--no-capture-output"]
CMD /bin/bash
