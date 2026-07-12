################################################################################
#
# uboot-txcz-rk3128-v3-1
#
################################################################################

UBOOT_TXCZ_RK3128_V3_1_VERSION = abfc9d0dc79dd0ab9d0e94c4b3c8d80e3a58b008
UBOOT_TXCZ_RK3128_V3_1_SITE = $(call github,mingrizaizao,u-boot-rockchip,$(UBOOT_TXCZ_RK3128_V3_1_VERSION))
UBOOT_TXCZ_RK3128_V3_1_LICENSE = GPLv2

UBOOT_TXCZ_RK3128_V3_1_DEPENDENCIES = rk3128-blobs

define UBOOT_TXCZ_RK3128_V3_1_BUILD_CMDS
    # Build uboot for txcz-rk3128-v3-1
    cd $(@D) && ARCH=arm CHIP=rk3128 \
        CROSS_COMPILE=$(HOST_DIR)/bin/arm-buildroot-linux-gnueabihf- \
        make txcz-rk3128-v3-1_defconfig
    cd $(@D) && ARCH=arm CHIP=rk3128 \
        CROSS_COMPILE=$(HOST_DIR)/bin/arm-buildroot-linux-gnueabihf- make

    # Generate idbloader.img
    $(BINARIES_DIR)/rkbin/tools/mkimage -n rk3128 -T rksd -d \
        $(BINARIES_DIR)/rkbin/bin/rk31/rk3128_ddr_300MHz_v2.12.bin \
        $(@D)/idbloader.img
    cat $(BINARIES_DIR)/rkbin/bin/rk31/rk3128x_miniloader_v2.57.bin >> \
        $(@D)/idbloader.img

    # Generate uboot.img
    $(BINARIES_DIR)/rkbin/tools/loaderimage --pack --uboot \
        $(@D)/u-boot-dtb.bin $(@D)/uboot.img --size 1024 4
  
    # Generate trust.img
     $(BINARIES_DIR)/rkbin/tools/loaderimage --pack --trustos \
        $(BINARIES_DIR)/rkbin/bin/rk31/rk3126_tee_ta_v2.04.bin \
        $(@D)/trust.img --size 1024 4
endef

define UBOOT_TXCZ_RK3128_V3_1_INSTALL_TARGET_CMDS
	cp $(@D)/idbloader.img $(BINARIES_DIR)/idbloader.img
	cp $(@D)/uboot.img     $(BINARIES_DIR)/uboot-txcz-rk3128-v3-1.img
	cp $(@D)/trust.img     $(BINARIES_DIR)/trust.img
endef

$(eval $(generic-package))
