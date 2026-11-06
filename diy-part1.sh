#!/bin/bash
# -----------------------------------------------------------------
# 注入第三方 feeds 软件源
# -----------------------------------------------------------------

# 1. 添加 NSS 硬件加速包软件源（与官方 mainline 保持一致）
echo 'src-git nss_packages https://github.com/AgustinLorenzo/nss-packages.git^e32b9e4b4ab4c52f2d0bee4377792453adbf403c' >> feeds.conf.default

# 2. 添加 PassWall 官方源码仓库及最新依赖源（编译时自动拉取最新 xray-core / sing-box）
echo 'src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall-packages.git;main' >> feeds.conf.default
echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall.git;main' >> feeds.conf.default

# 3. 添加打印与常用工具源
echo 'src-git printing https://github.com/logicplace/openwrt-printing-packages.git^edff7093ed70d19a437c528b29454c249eb4d931' >> feeds.conf.default
