#!/bin/bash
# -----------------------------------------------------------------
# 注入 ER2260T 适配补丁、设备树与专属脚本
# -----------------------------------------------------------------

# 1. 复制 DTS 设备树到 qualcommax 目标平台
DTS_DIR="target/linux/qualcommax/files/arch/arm64/boot/dts/qcom"
mkdir -p "$DTS_DIR"
cp -f patches/ipq8070-tl-er2260t.dts "$DTS_DIR/"

# 2. 如果 Makefile 中未定义 tplink_tl-er2260t，则追加其构建 Profile
TARGET_MK="target/linux/qualcommax/image/ipq807x.mk"
if ! grep -q "define Device/tplink_tl-er2260t" "$TARGET_MK"; then
cat << 'EOF' >> "$TARGET_MK"

define Device/tplink_tl-er2260t
	$(call Device/FitImage)
	$(call Device/UbiFit)
	DEVICE_VENDOR := TP-Link
	DEVICE_MODEL := TL-ER2260T
	BLOCKSIZE := 128k
	PAGESIZE := 2048
	SOC := ipq8070
	DEVICE_PACKAGES := kmod-i2c-gpio kmod-sfp kmod-usb-ledtrig-usbport \
		-ath11k-firmware-ipq8074 -kmod-ath11k-ahb -wpad-basic-mbedtls
endef
TARGET_DEVICES += tplink_tl-er2260t
EOF
fi

# 3. 修复 USB 供电问题（注入本地启动脚本）
sed -i '/exit 0/i devmem 0x1016000 32 0x201 && devmem 0x1016004 32 0x2' package/base-files/files/etc/rc.local

# 4. 调整 Argon 主题为默认
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile 2>/dev/null || true
