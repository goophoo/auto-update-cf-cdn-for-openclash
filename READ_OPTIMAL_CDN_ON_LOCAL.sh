#!/bin/bash
date > /root/CloudflareST_linux_mipsle/OPTIMAL_CDN_TMP && \
awk -F, 'NR < 6 && $1 ~ /[0-9]/ {print $1}' /root/CloudflareST_linux_mipsle/result.csv >> /root/CloudflareST_linux_mipsle/OPTIMAL_CDN_TMP && \
cat /root/CloudflareST_linux_mipsle/OPTIMAL_CDN_TMP | ssh -p 22 root@xxx.xxx.xxx.xxx -T "cat >> /root/OPTIMAL_CDN_ACCU" && \
ssh -p 22 root@xxx.xxx.xxx.xxx 'sh /root/UPDATE_CDN_ON_REMOTE.sh'