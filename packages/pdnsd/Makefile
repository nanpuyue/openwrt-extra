#
# Copyright (C) 2014 nanpuyue <nanpuyue@gmail.com>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=pdnsd
PKG_VERSION:=1.2.9a
PKG_RELEASE:=1
PKG_MAINTAINER:=nanpuyue <nanpuyue@gmail.com>

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-par.tar.gz
PKG_SOURCE_URL:=http://members.home.nl/p.a.rombouts/pdnsd/releases/
PKG_MD5SUM:=2f3e705d59a0f9308ad9504b24400769

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/pdnsd/default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=IP Addresses and Names
  URL:=http://members.home.nl/p.a.rombouts/pdnsd
endef

define Package/pdnsd
  $(call Package/pdnsd/default)
  DEPENDS:=+libpthread
  TITLE:=A proxy DNS server with permanent caching
endef

define Package/pdnsd-ctl
  $(call Package/pdnsd/default)
  DEPENDS:=+pdnsd
  TITLE:= pdnsd-ctl controls pdnsd(a proxy dns server)
endef

define Package/pdnsd/description
	pdnsd is a IPv6 capable proxy domain name server (DNS) which saves the contents of its DNS cache to the disk on exit.
endef

define Package/pdnsd-ctl/description
	pdnsd-ctl controls pdnsd, a proxy dns server with permanent caching. Note that the status control socket must be enabled (by specifying an option on the pdnsd command line or in the configuration file) before you can use pdnsd-ctl.
endef

CONFIGURE_ARGS += \
	--prefix=/usr \
	--sysconfdir=/etc \
	--enable-ipv6

TARGET_CFLAGS += \
	-fdata-sections \
	-ffunction-sections

TARGET_LDFLAGS += \
	-Wl,-gc-sections

MAKE_FLAGS += \
	CFLAGS="$(TARGET_CFLAGS)" \
	LDFLAGS="$(TARGET_LDFLAGS)"

define Package/pdnsd/conffiles
/etc/pdnsd.conf
endef

define Package/pdnsd/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/pdnsd.init $(1)/etc/init.d/pdnsd
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/etc/pdnsd.conf.sample $(1)/etc/pdnsd.conf
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/pdnsd $(1)/usr/sbin
endef

define Package/pdnsd-ctl/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/pdnsd-ctl $(1)/usr/sbin
endef

$(eval $(call BuildPackage,pdnsd))
$(eval $(call BuildPackage,pdnsd-ctl))
