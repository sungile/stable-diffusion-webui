FROM nvidia/cuda:11.7.1-base-ubuntu22.04
FROM python:3.10

# Install necessary dependencies
RUN apt update && \
    apt install -y wget git python3 python3-venv 
RUN apt-get update && apt-get install -y libgl1-mesa-glx -y libglib2.0-0

# Set the NVIDIA_VISIBLE_DEVICES environment variable
ENV NVIDIA_VISIBLE_DEVICES=all
# # Create a non-root user
RUN useradd -ms /bin/bash myuser

# # Switch to the non-root user
USER myuser

# # Set the working directory
WORKDIR /home/myuser

# # Clone the open-source project
RUN git clone -b users/sungile/aistaging https://github.com/sungile/stable-diffusion-webui.git

# # Set the working directory
WORKDIR /home/myuser/stable-diffusion-webui

# Clone the repository into the "extensions" directory
RUN git clone https://github.com/Mikubill/sd-webui-controlnet.git /home/myuser/stable-diffusion-webui/extensions/sd-webui-controlnet

ENV COMMANDLINE_ARGS="--skip-torch-cuda-test --precision full --no-half"

RUN bash -c "/home/myuser/stable-diffusion-webui/webui.sh --test-server"

CMD ["bash", "webui.sh","--start-server","--skip-prepare-environment"]