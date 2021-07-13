sudo mkdir ./ssl
# Generate RSA Private Key 
sudo openssl genrsa -out ./ssl/fleet.key 4096
# CSR(Certificate Signing Request) 생성 시, Common Name 설정 유의 필요
sudo openssl req -new -key ./ssl/fleet.key -out ./ssl/fleet.csr
sudo openssl x509 -req -days 366 -in ./ssl/fleet.csr -signkey ./ssl/fleet.key -out ./ssl/fleet.crt
