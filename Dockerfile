FROM httpd

COPY ./privkey.pem /usr/local/apache2/conf/server.key
COPY ./fullchain.pem /usr/local/apache2/conf/server.crt
COPY ./httpd.conf /usr/local/apache2/conf/httpd.conf
COPY ./httpd-ssl.conf /usr/local/apache2/conf/extra/httpd-ssl.conf 
