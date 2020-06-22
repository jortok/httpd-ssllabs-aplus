# USAGE

1. Just put your SSL Certificates in the same folder, in this example I use a free certificates from Letsencrypt. The `Dockerfile` will rename it in the HTTPD expected name.

- `privkey.pem` --> `/usr/local/apache2/conf/server.key`
- `fullchain.pem` --> `/usr/local/apache2/conf/server.crt`

2. Build the image with the Dockerfile

```  
docker build -t <image_name> .
```

3. Run the image

```
docker run -dit -p 80:80 -p 443:443 --name www -v /var/www/html:/usr/local/apache2/htdocs/ <image_name>
```
