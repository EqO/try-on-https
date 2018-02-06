#!/bin/sh

cat <<EOF
You have just started "Try on HTTPS" in Docker container. 
Special thanks to marvambass/nginx-ssl-secure container
for super secure SSL/TLS setup.
EOF

if [ -z ${DH_SIZE+x} ]
then
  >&2 echo ">> no \$DH_SIZE specified using default" 
  DH_SIZE="2048"
fi


DH="/etc/nginx/tls/dh.pem"

if [ ! -e "$DH" ]
then
  echo ">> seems like the first start of nginx"
  echo ">> doing some preparations..."
  echo ""

  echo ">> creating directory for storing TLS credentials"
  [ -d /etc/nginx/tls ] || mkdir /etc/nginx/tls
  [ -f /etc/nginx/tls/req.conf ] || mv /req.conf /etc/nginx/tls/req.conf

  echo ">> generating $DH with size: $DH_SIZE"
  openssl dhparam -out "$DH" $DH_SIZE
fi

if [ ! -e "/etc/nginx/tls/cert.pem" ] || [ ! -e "/etc/nginx/tls/key.pem" ]
then
  echo ">> generating self signed cert"
  openssl req -x509 -newkey rsa:4086 \
  -config "/etc/nginx/tls/req.conf" \
  -keyout "/etc/nginx/tls/key.pem" \
  -out "/etc/nginx/tls/cert.pem" \
  -days 3650 -nodes -sha256
fi

# exec CMD
echo ">> exec docker $@"
echo ">> Follow on https://localhost:4443"
exec "$@"
