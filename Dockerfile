FROM nvidia/cuda:121.1-runtime-ubuntu22.04

ENV PYTHONUNBUFFERED=1
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    git python3 python3-pip python3-venv wget curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /root

RUN git clone https://github.com/comfyanonymous/ComfyUI.git

WORKDIR /root/ComfyUI
RUN pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
RUN pip install -r requirements.txt

RUN git clone https://github.com/ltdrdata/ComfyUI-Manager custom_nodes/ComfyUI-Manager

COPY start.sh /root/start.sh
RUN chmod +x /root/start.sh

EXPOSE 8188
CMD ["/root/start.sh"]
