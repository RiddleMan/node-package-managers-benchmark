FROM alpine:3.14

RUN apk --no-cache add bash curl git gawk gnupg openssl && \
    # FNM
    curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell && \
    # Volta
    curl https://get.volta.sh | bash -s -- --skip-setup && \
    # asdf
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1 && \
    bash -c 'source ~/.asdf/asdf.sh && asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git' && \
    # NVM
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
