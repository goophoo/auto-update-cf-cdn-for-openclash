# auto-update-cf-cdn-for-openclash

Auto updating optimal cloudflare cdn nodes for [OpenClash](https://github.com/vernesong/OpenClash) on openwrt based on the result of [CloudflareSpeedTest](https://github.com/XIU2/CloudflareSpeedTest)

根据[CloudflareSpeedTest](https://github.com/XIU2/CloudflareSpeedTest)的结果，自动为openwrt上[OpenClash](https://github.com/vernesong/OpenClash)更新最优cloudflare节点。

使用方法
---

在主路由上放置READ_OPTIMAL_CDN_ON_LOCAL.sh

在OpenClash所在路由上放置UPDATE_CDN_ON_REMOTE.sh

在crontab里添加定时任务

0 2 * * * cd /root/CloudflareST_linux_mipsle && ./CloudflareST -dn 5 && sh /root/READ_OPTIMAL_CDN_ON_LOCAL.sh


