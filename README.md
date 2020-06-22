# OBJETIVE
Ths is a Dockerfile to build a container from the latest HTTPD image with A+ Overall Rating in [SSL Labs](https://www.ssllabs.com/ssltest/index.html) with hardenized options.

## PREREQUITES
Have your own SSL Certificate in the same folder.
```
-rw------- 1 root root  1708 Jun 22 05:22 privkey.pem
-rw-r--r-- 1 root root  3562 Jun 22 05:22 fullchain.pem
-rw-r--r-- 1 root root   692 Jun 22 05:22 README.md
-rw-r--r-- 1 root root 20929 Jun 22 05:27 httpd.conf
-rw-r--r-- 1 root root   243 Jun 22 05:38 Dockerfile
-rw-r--r-- 1 root root 13900 Jun 22 18:33 httpd-ssl.conf
```

## USAGE

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
