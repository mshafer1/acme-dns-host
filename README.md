# mTLS Nginx ACME DNS


This provides an ACME DNS (Automatic Certificate Management Environment) server setup that requires [mutual TLS (mTLS)](https://www.cloudflare.com/learning/access-management/what-is-mutual-tls/) for API access.

# ⚠️ UPDATE ⚠️
I did all this work, built this (and supporting infrastructure - including a Linode StackScript to deploy it) and then found out that the tunnel proxy I was planning to put in front of this (CloudFlare 0 Trust) doesn't support a "bring your own mTLS". 

I can leverage their mTLS setup (which I didn't know about when I started this), but the tunnel strips off the client cert. I'm not sure what that means about the future of this project. For now, I'm going to go setup a simpler install that just uses CloudFlare's mTLS and proxies to my server (running joohoi/acme-dns directly).

&nbsp;

# Why?

Due to the nature of ACME DNS challenges, this server has to be on the public web. In order to make it as secure as I know how, I opted to wrap [joohoi/acme-dns](https://github.com/joohoi/acme-dns) behind nginx and require mTLS for access to the api.

# How?

## Docker networking

Using a macvlan, the network that the `joohoi/acme-dns` container runs in is not exposed to the firewall / internet.

## DNS Proxy

[`dnsmasq`](https://thekelleys.org.uk/dnsmasq/doc.html) is configured as a non-caching relay/proxy DNS server

## NGINX reverse proxy

This service runs [NGINX](https://nginx.org/en/) as a reverse web proxy with mTLS required for access.

Some docs used in building and testing this are:
- https://docs.nginx.com/waf/configure/secure-mtls/
- https://smallstep.com/hello-mtls/doc/client/requests
- https://nginx.org/en/docs/http/ngx_http_ssl_module.html


