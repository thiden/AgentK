FROM python:3-bullseye

#安装rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

#安装CMake
RUN apt-get update && apt-get install -y cmake

# 安装 libclang-dev
RUN apt-get update && apt-get install -y libclang-dev

RUN apt-get -y update

WORKDIR /tmp
COPY apt-packages-list.txt /tmp/apt-packages-list.txt
RUN apt-get update
RUN xargs -a apt-packages-list.txt apt-get install -y --fix-missing
# RUN xargs -a apt-packages-list.txt apt-get install -y

COPY requirements.txt /tmp/requirements.txt
RUN pip install -r requirements.txt

WORKDIR /app
COPY . /app
ENTRYPOINT ["python", "agent_kernel.py"]


