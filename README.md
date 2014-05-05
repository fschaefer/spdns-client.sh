spdns-client.sh
===============

Shell script to update DNS records on http://spdns.de/

Usage:
```
spdns-client.sh 1.0
Usage:	spdns-client.sh -u <username> -p <password> -d <host> [-i <IP>]

Supported options:
    -h              print this help message
    -v              print version
    -u  <user>      username
    -p  <pass>      password
    -d  <host>      hostname
    -i  <IP>        IP address; if omitted or value is in private
                    subnet (10.0.0.0/8, 172.16.0.0/20 or 192.168.0.0/16)
                    the requesting IP is used
```
