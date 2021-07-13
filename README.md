### Requirements
If you want to use fleet, docker and docker-compose must be installed.

### Running Fleet
```bash
$ cd / && git clone https://github.com/woodonggyu/fleet.git

$ cd /fleet && chmod +x ./installation.sh

$ ./installation.sh
Generating RSA private key, 4096 bit long modulus
.++
.....++
...
Common Name (eg, your name or your server hostname) []: [hostname]
...
Getting Private key

$ docker-compose up -d
...
Starting [redis container name]     ... done
Starting [mariadb container name]   ... done
Starting [fleet container name]     ... done


Now, Ready to start.
Open a browser (ex. https://[hostname])
```


### Manage Fleet (using fleetctl)
Basically, some configuration is required to use fleetctl.
Initial setting for login is required as follows.

```bash
$ docker exec -itu 0 [container] /bin/sh

$ fleetctl config set --address https://[hostname]:[port] --tls-skip-verify

$ fleetctl setup --email [email]
Password:
[+] Fleet setup successful and context configured!

$ fleetctl login
Log in using the standard Fleet credentials.
Email/Username:
Password:
[+] Fleet login successful and context configured!
```


### Add User
```bash
$ fleetctl user create --username [id] --email [email]
```


### Update osquery options
```bash
$ fleetctl apply -f /fleet/options.yaml
```


### Connecting a host
To get your osquery enroll secret, run the following:
```bash
$ fleetctl get enroll_secret
---
apiVersion: ~
kind: enroll_secret
spec:
  secrets:
  - active: true
    created_at: ~
    name: default
    secret: [enroll_secret]
```

To connecting agent, run the following:
Before running the command below, You must download the "enroll_secret" value and the "fleet.crt" file.
```bash
$ echo "[encroll_secret]" > /var/osquery/enroll_secret

$ cp fleet.crt /var/osquery/

$ systemctl restart osqueryd.service
```
