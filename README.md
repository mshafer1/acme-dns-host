# acme-dns-host

This repo contains a Docker compose config to enable deploying [joohoi/acme-dns](https://github.com/joohoi/acme-dns).

# Why?

I'll refer you to the [first attempt](https://github.com/mshafer1/mTLS-acme-dns-host).

# Installation

1. Clone repo

    ```bash
    git clone https://github.com/mshafer1/acme-dns-host.git
    cd acme-dns-host
    ```

1. Copy `example.env` to `.env` and configure

    ```bash
    cp example.env .env
    # for configuration, use a text editor and the examples in the comments
    ```

1. Bring up the server

    `docker compose up -d`
