# TP-Link TL-ER2260T OpenWrt 自动编译工作流 (针对 128MB Flash 优化)

本项目用于在 GitHub Actions 上自动编译适配 **TP-Link TL-ER2260T** 的最新 OpenWrt Mainline 固件。

### 为什么采用云端编译更新插件？
ER2260T 只有 128MB 闪存（可写空间仅剩 40~60MB）。如果通过系统终端在线更新 Xray-core、Sing-box 或安装大插件，会瞬间占满闪存导致系统崩溃。
**通过 GitHub Actions 编译时将最新版 Xray、Sing-box 和 PassWall 打包入只读压缩镜像（SquashFS），完全不占用闪存可写空间。**

---

### 一、快速开始（推送到你的 GitHub 仓库）

1. 在 GitHub 上新建一个空仓库（例如命名为 `er2260t-builder`）；
2. 在本地当前目录打开终端，将此文件夹推送到你的 GitHub 仓库：

```bash
git init
git add .
git commit -m "feat: init er2260t openwrt build workflow"
git branch -M main
git remote add origin https://github.com/<你的用户名>/er2260t-builder.git
git push -u origin main
```

3. **赋予 Actions 读写权限（非常重要）**：
   - 打开 GitHub 仓库页面，点击 **Settings** -> **Actions** -> **General**；
   - 滚动到 **Workflow permissions**，勾选 **Read and write permissions**，点击 **Save**。

---

### 二、触发编译与下载固件

1. 点击仓库顶部的 **Actions** 标签页；
2. 在左侧选择 **Build TP-Link TL-ER2260T Firmware**；
3. 点击右侧 **Run workflow** 下拉按钮，点击绿色的 **Run workflow** 开始编译；
4. 编译耗时约 1.5 ~ 2 小时，编译成功后：
   - 固件会自动发布在仓库的 **Releases** 页面；
   - 下载 `openwrt-qualcommax-ipq807x-tplink_tl-er2260t-squashfs-sysupgrade.bin`。

---

### 三、路由器日常无损升级

1. 登录已刷好 OpenWrt 的 ER2260T 网页后台；
2. 进入 **系统 -> 备份/升级**；
3. 上传下载好的 `...-sysupgrade.bin` 固件；
4. 点击 **刷写固件**，等待 2~3 分钟自动重启完成无损升级。
