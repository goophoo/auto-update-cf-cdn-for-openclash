#!/bin/bash
date > /root/LOG/LOG_OPTIMAL_CDN_CF_CFT_IPv6_AP_TMP.log && \
awk -F, 'NR < 7 && $1 ~ /[0-9]/ {print $1}' /root/SCRIPTS/CloudflareST_linux_mipsle_2.2.2/result.csv >> /root/LOG/LOG_OPTIMAL_CDN_CF_CFT_IPv6_AP_TMP.log