FROM debian:bookworm-slim as build-env

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y \
  # install tools
  && apt install -y --no-install-recommends git curl ca-certificates \
  # install python dependencies
  && apt install -y --no-install-recommends make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev libsqlite3-dev \
  # make image smaller
  && rm -rf "/var/lib/apt/lists/*" \
  && rm -rf /var/cache/apt/archives

RUN useradd -m pythonuser

WORKDIR /home/pythonuser
USER pythonuser

RUN git clone https://github.com/pyenv/pyenv.git ~/.pyenv
ENV PATH /home/pythonuser/.pyenv/shims:/home/pythonuser/.pyenv/bin:$PATH

ENV PYTHON_VERSION 3.12.3
RUN pyenv install --list | grep -A7 $PYTHON_VERSION \
  && pyenv install $PYTHON_VERSION \
  && pyenv global $PYTHON_VERSION \
  && pyenv rehash \
  && python --version

WORKDIR /home/pythonuser/app

RUN pip install fastapi \
  && pip install pydantic \
  && pip install uvicorn \
  && pip freeze

COPY main.py .

EXPOSE 8000

CMD ["uvicorn", "main:app", "--reload", "--host", "0.0.0.0", "--port", "8000"]

HEALTHCHECK CMD curl -f "http://localhost:8000" || exit 1
