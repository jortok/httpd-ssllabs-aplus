# USAGE

1. Just put your SSL Certificates in the same folder, in this example I use a free certificates from Letsencrypt. The `Dockerfile` will rename it in the HTTPD expected name.

- `privkey.pem` --> `/usr/local/apache2/conf/server.key`
- `fullchain.pem` --> `/usr/local/apache2/conf/server.crt`

2. Modify the `httpd.conf` file at the bottom to your domain name in order to redirect from HTTP to HTTPS.

```
<VirtualHost *:80>
        ServerName your.domain.com
        Redirect 301 / https://your.domain.com/
</VirtualHost>
```

3. Edit the `httpd-ssl.conf` in the `ServerName` and `ServerAdmin` options with your information.

4. Build the image with the Dockerfile

```  
docker build -t <image_name> .
```

5. Run the image

```
docker run -dit -p 80:80 -p 443:443 --name www -v /var/www/html:/usr/local/apache2/htdocs/ <image_name>
```

## NOTES
- The `SSLCipherSuite` is modified to:
```
SSLCipherSuite ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384
```
- The SSL protocols are the following:
```
SSLProtocol all -SSLv3 -TLSv1 -TLSv1.1
```
