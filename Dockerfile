# DogeSpeed AnyConnect server recipe
# ----- Yum!

# We need Debian testing (currently stretch) for the ocserv package
FROM debian:testing
MAINTAINER hello@zhaofeng.li

# Override the default sources.list
COPY sources.list /etc/apt/sources.list

# Install required packages via APT
RUN apt-get update && apt-get install -y openssh-server ocserv wget curl cron supervisor openssl python git gnutls-bin iptables

# Set up letsencrypt.sh
RUN git clone --depth=1 https://github.com/lukas2511/dehydrated /opt/letsencrypt.sh

# Set up supervisord
COPY supervisord.conf /etc/supervisord.conf

# Set up ocserv
COPY ocserv/ /etc/ocserv/
RUN certtool --generate-dh-params --outfile /etc/ocserv/dh.pem

# Set up cron
RUN crontab /etc/ocserv/crontab
RUN chmod 600 /etc/crontab

# Set up dogespeed util
COPY bin/dogespeed /usr/local/bin

# Create ocserv worker user
RUN useradd -r algiz

# When running:
# --> Please publish port 80 and 443 for ocserv
EXPOSE 80 443

# --> Please make /dogespeed persistent
VOLUME /dogespeed

# Define entrypoints. Here we go!
ENTRYPOINT ["/usr/local/bin/dogespeed"]
CMD ["start"]
