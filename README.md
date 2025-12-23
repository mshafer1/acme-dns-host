# mTLS Nginx ACME DNS

This provides and ACME DNS server setup that requires [mutual TLS (mTLS)](https://www.cloudflare.com/learning/access-management/what-is-mutual-tls/) for API access.

# Why?

Due to the nature of ACME DNS challenges, this server has to be on the public web. In order to make it as secure as I know how, I opted to wrap [joohoi/acme-dns](https://github.com/joohoi/acme-dns) behind nginx and require mTLS for access to the api.