FROM ubuntu:22.04 as OS
USER root
WORKDIR /home
RUN apt-get update && apt-get install -y --no-install-recommends \
 wget \
 unzip \
 nginx \
 openssl \
 systemctl \
 gettext \
 vim
RUN wget https://github.com/XTLS/Xray-core/releases/download/v1.8.4/Xray-linux-64.zip --no-check-certificate  && \
 mkdir /opt/xray && \
 unzip ./Xray-linux-64.zip -d /opt/xray && \
 chmod +x /opt/xray/xray && \
 openssl req -x509 -newkey rsa:4096 -nodes -sha256 -keyout /etc/ssl/private/ssl-cert-snakeoil.key -out /etc/ssl/certs/ssl-cert-snakeoil.pem -days 10950 -subj "/CN=you_dont_know_me_fuck_off"
COPY ./default /etc/nginx/sites-enabled/
COPY ./config.json /opt/xray/config.json_prepare
CMD /bin/bash -c "envsubst < /opt/xray/config.json_prepare > /opt/xray/config.json && systemctl start nginx && /opt/xray/xray run -c /opt/xray/config.json"
