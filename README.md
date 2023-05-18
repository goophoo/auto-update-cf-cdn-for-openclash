# auto-update-cf-cdn-for-openclash

Auto updating optimal cloudflare cdn nodes for [OpenClash](https://github.com/vernesong/OpenClash) on [openwrt](https://github.com/openwrt/openwrt) based on the result of [CloudflareSpeedTest](https://github.com/XIU2/CloudflareSpeedTest)

根据[CloudflareSpeedTest](https://github.com/XIU2/CloudflareSpeedTest)的结果，自动为[openwrt](https://github.com/openwrt/openwrt)上[OpenClash](https://github.com/vernesong/OpenClash)更新最优cloudflare节点。

## 20230518
1. CFT was added;
2. IPv4 and IPv6 speed tests were separated;
3. Output of logs were added;
4. Invoking Cloudflare API to update DNS A/AAAA records was added instead of restarting openclash in previous version;
### Usage
1. Make sure there are already configured A/AAAA records like cf1.xxxx.com, cf2.xxxx.com, cf3.xxxx.com, cf4.xxxx.com, cf5.xxxx.com, cft1.xxxx.com, cft2.xxxx.com, cft3.xxxx.com, cft4.xxxx.com, cft5.xxxx.com etc in your Cloudflare DNS; watch this video for more info, https://youtu.be/3y57YVt-PuQ?list=PLlMCmc8H8dX32NnftezyuNbgsj8vpsbUq&t=274
2. Replace your own Cloudflare API info in all "SH_UPDATE_OPTIMAL_CDN*.sh" files with your own;
3. Put all "SH_READ_OPTIMAL_CDN*.sh" files on any router that has no openclash installed on it;
4. Put all "SH_UPDATE_OPTIMAL_CDN*.sh" files on any router that has openclash installed on it;
5. Add crontab task on the router on which you just put "SH_READ_OPTIMAL_CDN*.sh", for instance, test for the optimal IPv4 CDN nodes of CF and CFT at 04:06 on every Tuesday, IPv6 CDN nodes at the same time on every Friday;
``` sh
6 4 * * 2 cd /root/SCRIPTS/CloudflareST_linux_mipsle_2.2.2 && ./CloudflareST -dn 5 && sh /root/SCRIPTS/SH_READ_OPTIMAL_CDN_CF_LOCAL_IPv4.sh && ./CloudflareST -f CDN_CFT_IPv4.txt -dn 5 -t 1 -url https://youownnode.cloudfront.net/100mb.test && sh /root/SCRIPTS/SH_READ_OPTIMAL_CDN_CFT_LOCAL_IPv4.sh
6 4 * * 5 cd /root/SCRIPTS/CloudflareST_linux_mipsle_2.2.2 && ./CloudflareST -f ipv6.txt -dn 5 && sh /root/SCRIPTS/SH_READ_OPTIMAL_CDN_CF_LOCAL_IPv6.sh && ./CloudflareST -f CDN_CFT_IPv6.txt -dn 5 -t 1 -url https://youownnode.cloudfront.net/100mb.test && sh /root/SCRIPTS/SH_READ_OPTIMAL_CDN_CFT_LOCAL_IPv6.sh
```

### Examples of LOG_UPDATE_OPTIMAL_CDN_A_RECORD.log:

![LOG_OPTIMAL_CDN_CF_CFT_IPv4_TMP](https://github.com/goophoo/auto-update-cf-cdn-for-openclash/assets/112747189/63093297-57f2-44dd-a0a7-489ad4b7bba7)
![LOG_UPDATE_OPTIMAL_CDN_A_RECORD](https://github.com/goophoo/auto-update-cf-cdn-for-openclash/assets/112747189/c0016cc3-1776-4695-ba7b-8b8991b3a59a)


## 20220903
### 使用方法
1. 需要先将脚本中相关目录和IP地址替换为自己路由器对应的值;

2. 在主路由上放置READ_OPTIMAL_CDN_ON_LOCAL.sh

3. 在OpenClash所在路由上放置UPDATE_CDN_ON_REMOTE.sh

4. 在主路由crontab里添加定时任务: 0 2 * * * cd /root/CloudflareST_linux_mipsle && ./CloudflareST -dn 5 && sh /root/READ_OPTIMAL_CDN_ON_LOCAL.sh


