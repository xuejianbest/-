privoxy /etc/privoxy/config

proxy="http://127.0.0.1:8118"
export http_proxy=$proxy
export https_proxy=$proxy
export no_proxy="localhost, 127.0.0.1, ::1"
