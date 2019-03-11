### Install
##### CentOS
```shell
yum install python-pip
pip install shadowsocks
```

##### Ubuntu
```shell
apt -y install python3-pip
pip3 install setuptools
pip3 install https://github.com/shadowsocks/shadowsocks/archive/master.zip -U
```
or
```shell
apt -y install python3-pip && \
pip3 install setuptools && \
pip3 install https://github.com/shadowsocks/shadowsocks/archive/master.zip -U
```

### ssconf
```json
{
  "server":"::",
  "server_port":443, 
  "password":"***",
  "fast_open":true, 
  "method":"aes-256-gcm", 
  "timeout":70
}

{
  "server":"::",
  "port_password": {
    "443": "**1",
    "7443": "**2"
  },
  "method": "aes-128-cfb",
  "timeout": 70
}
```

---
### ssserver
```shell
ssserver -c ssconf -d start
ssserver -c ssconf -d stop
```

---
### sslocal
```shell
sslocal -c ssconf -d start
sslocal -c ssconf -d stop
```

---
### privoxy
```shell
yum install privoxy
vim /etc/privoxy/config
# 将 forward-socks5t / 127.0.0.1:9050 取消注释
# 改为forward-socks5t / 127.0.0.1:1080
```

```shell
proxy="http://127.0.0.1:8118"
export http_proxy=$proxy
export https_proxy=$proxy
export no_proxy="localhost, 127.0.0.1, ::1"

privoxy /etc/privoxy/config
```

### docker
```shell
vim /etc/shadowsocks-libev/config.json
{
    "server":"::",
    "server_port":443,
    "password":"***",
    "timeout":300,
    "method":"chacha20-ietf-poly1305",
    "fast_open":true,
    "nameserver":"8.8.8.8",
    "mode":"tcp_and_udp",
    "plugin":"obfs-server",
    "plugin_opts":"obfs=tls"
}

docker run -d -p 443:9000 -p 443:9000/udp --name ss -v /etc/shadowsocks-libev:/etc/shadowsocks-libev teddysun/shadowsocks-libev
```





