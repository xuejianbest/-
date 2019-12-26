
### Install

#### 一键安装脚本
```shell
wget --no-check-certificate -O shadowsocks-all.sh https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-all.sh
chmod +x shadowsocks-all.sh
./shadowsocks-all.sh 2>&1 | tee shadowsocks-all.log
```

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
#### 安装配置
```shell
yum install privoxy
vim /etc/privoxy/config
```
将 `forward-socks5t / 127.0.0.1:9050 .` 取消注释
改为 `forward-socks5t / 127.0.0.1:1080 .`

#### 启动
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
    "server":"0.0.0.0",
    "server_port":9000,
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


### CentOS安装shadowsocks-libev并启用混淆
#### 安装shadowsocks-libev
github地址：https://github.com/shadowsocks/shadowsocks-libev
```shell
curl https://copr.fedorainfracloud.org/coprs/librehat/shadowsocks/repo/epel-7/librehat-shadowsocks-epel-7.repo > /etc/yum.repos.d/ss.repo
yum update
yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install -y shadowsocks-libev
```

#### 安装obfs-local
github地址：https://github.com/shadowsocks/simple-obfs
```shell
yum -y install gcc autoconf libtool automake make zlib-devel openssl-devel asciidoc xmlto libev-devel
git clone https://github.com/shadowsocks/simple-obfs.git
cd simple-obfs
git submodule update --init --recursive
./autogen.sh
./configure && make
sudo make install
```

#### 启动客户端
```shell
ss-local \
-s 110.110.110.110 \
-p 443 \
-k password \
-l 1080 \
-m chacha20-ietf-poly1305 \
--plugin obfs-local \
--plugin-opts "obfs=http;obfs-host=www.bing.com"
```

