################################################################################
#
# kernel-linaro-toolchain
#
################################################################################

KERNEL_LINARO_TOOLCHAIN_VERSION = v6.3.1

KERNEL_LINARO_TOOLCHAIN_SOURCE = \
    gcc-linaro-6.3.1-2017.05-i686_arm-linux-gnueabihf.tar.xz

KERNEL_LINARO_TOOLCHAIN_SITE = \
    https://github.com/mingrizaizao/kernel-toolchains/releases/download/$(KERNEL_LINARO_TOOLCHAIN_VERSION)

KERNEL_LINARO_TOOLCHAIN_INSTALL_DIR = \
    $(HOST_DIR)/kernel-linaro-toolchain

define HOST_KERNEL_LINARO_TOOLCHAIN_INSTALL_CMDS
    rm -rf $(KERNEL_LINARO_TOOLCHAIN_INSTALL_DIR)
    mkdir -p $(KERNEL_LINARO_TOOLCHAIN_INSTALL_DIR)
    cp -a $(@D)/* $(KERNEL_LINARO_TOOLCHAIN_INSTALL_DIR)/
endef

$(eval $(host-generic-package))
