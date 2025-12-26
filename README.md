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

# Linode deployment

To simplify deployment on [Linode by Akami (referral link)](https://www.linode.com/lp/refer/?r=e8209b05a9908b71524dd45bd12eaf0a001ee4d1)*, I made a "StackScript" (and then I also set it as public).

[Stack Script direct link](https://cloud.linode.com/stackscripts/1980512)

This should be able to be deployed by going through the dialog; however, for repetability, I wrapped it in a private StackScript like the following:

```bash
#!/bin/bash

set -euo pipefail
trap 'echo "Error occurred on line $LINENO"; exit 1' ERR

exec > >(tee -i /var/log/stackscript_1.log)

export hostname=acme-dns
# TODO: Fill in the fully-qualified domain name (this is the domain that cname's will point to)
export fqdn=
export ufw_allowed_apps="ssh 53"
# TODO: fill in admin email address for joohoi/acme-dns
export ns_admin_email=

# apparently there's nothing "stacked" about these, but echoing the path here tells Linode to download "StackScript Bash Library" as well so it's available to 1980512
echo <ssinclude StackScriptID="1">

. <ssinclude StackScriptID="1980512">

# to enable USE_HEADER, uncomment the following lines (necessary if using Cloudflare Tunnel or similar)
# sed -r -e 's/#? ?USE_HEADER=.*$/USE_HEADER=true/g ' -i /app/acme_dns/.env
# pushd /app/acme_dns
# docker compose down
# docker compose up -d

#-------------
# Example setup cloudflare tunnel (uncomment and fill in to use)
#------------
# mkdir -p /app/tunnel/
# echo 'docker run -d --pull always cloudflare/cloudflared:latest tunnel --no-autoupdate run --token ...' > /app/tunnel/run
# chmod +x /app/tunnel/run
# /app/tunnel/run

figlet Success
```

\* For transparency - At the time of writing, Linode's referral setup is:
- Person A shares referral link
- Person B signs up -> they receive a $100 credit which is good for 60 days
- Once Person B spends $25 on Linode (the credit does not count), Person A receives $25 credit.
