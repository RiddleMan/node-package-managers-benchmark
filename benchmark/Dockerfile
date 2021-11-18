FROM ubuntu:22.04

RUN apt-get update && apt-get install -y curl git gawk gnupg openssl dirmngr unzip time

# Needs seperate shell (and layer) to load all PATHs created by the previous step
RUN curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell && \
   # Volta
   curl https://get.volta.sh | bash -s -- --skip-setup && \
   # asdf
   git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1 && \
   bash -c 'source ~/.asdf/asdf.sh && asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git' && \
   # NVM
   curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash && \
   rm -rf /var/lib/apt/lists/*

WORKDIR /benchmark/
COPY .bashrc* ./
