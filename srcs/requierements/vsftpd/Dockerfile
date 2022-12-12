FROM	debian:buster

ARG	SSL_FTP_KEY_PATH
ARG	SSL_FTP_CERT_PATH
ARG	FTP_USER_NAME
ARG	FTP_USER_PWD

RUN	apt-get update && apt-get install -y \
	vsftpd \
	openssl \
	gettext \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

RUN	mkdir -p /var/run/vsftpd/empty && mkdir -p /etc/vsftpd \
	&& useradd --no-create-home $FTP_USER_NAME \
	&& echo "$FTP_USER_NAME:$FTP_USER_PWD" | chpasswd \
	&& mkdir -p $(dirname $SSL_FTP_KEY_PATH) && mkdir -p $(dirname $SSL_FTP_CERT_PATH) && openssl req \
	-x509 \
	-nodes \
	-days 365 \
	-newkey rsa:2048 \
	-keyout $SSL_FTP_KEY_PATH -out $SSL_FTP_CERT_PATH \
	-subj "/C=FR/ST=Ile-de-France/L=Paris/O=42 Network/OU=Ecole 42/CN=plouvel.42.fr"

COPY	conf/vsftpd.conf	/vsftpd.conf.template
COPY	tools/configure.sh	/configure.sh

RUN	chmod +x /configure.sh

EXPOSE 21 20 21000

ENTRYPOINT ["/configure.sh"]
CMD ["vsftpd"]
