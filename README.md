# vpnbox
Easily deployable solution for a cloud VPN server! (WIP)

## Configuration
Create a new file named `ikev2.env` in the `data/` folder and configure it as follows, replacing data as convenient:

```
TZ=UTC
SHARED_SECRET=VerySecretPassword123.
HOST_ADDR=55.1.1.1
VPN_SUBNET=10.0.0.0/8
VPN_SUBNET_IP6=fd8e:49ea:091f:1ec3::/64
HOST_FQDN=myvpnserver.com
CONN_NAME=My VPN Profile
```
