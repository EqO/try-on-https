# Try on HTTPS

If you are willing to try how would your web page look like when switched on HTTPS, then this HTTPS off-loading reverse proxy can help you. To make it easier to be installed and removed, it comes as a Docker container image.


## Simple initialization

Download `docker-compose.yaml` file.

```
docker-compose up
```
Give it some time for certificates to be generated.

Add certificate from directory `tls` into your trusted certificates.


## Simple usage

```
docker-compose up
```

https://localhost:4443/

Enter URL you want to try on HTTPS.
