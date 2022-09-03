#!/bin/bash
sed -i 's/\r//' /root/OPTIMAL_CDN_ACCU && \

a=$(tail -4 OPTIMAL_CDN_ACCU | head -1) && \
b=$(tail -3 OPTIMAL_CDN_ACCU | head -1) && \
c=$(tail -2 OPTIMAL_CDN_ACCU | head -1) && \
d=$(tail -1 OPTIMAL_CDN_ACCU) && \

uci set openclash.@servers[0].server=$a && \
uci set openclash.@servers[1].server=$a && \
uci set openclash.@servers[2].server=$b && \
uci set openclash.@servers[3].server=$b && \
uci commit && \
#sed -i "w s|[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}|$c|" /etc/openclash/proxy_provider/PROXY_PROVIDER.yaml && \
#sed -i "x s|[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}|$c|" /etc/openclash/proxy_provider/PROXY_PROVIDER.yaml && \
#sed -i "y s|[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}|$d|" /etc/openclash/proxy_provider/PROXY_PROVIDER.yaml && \
#sed -i "z s|[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}|$d|" /etc/openclash/proxy_provider/PROXY_PROVIDER.yaml && \
/etc/init.d/openclash restart
