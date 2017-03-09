#
# Copyright (C) 2017 nanpuyue <nanpuyue@gmail.com> https://blog.nanpuyue.com
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=udns
PKG_VERSION:=0.4
PKG_RELEASE:=1
PKG_FIXUP:=autoreconf
PKG_LICENSE:=LGPL

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://www.corpit.ru/mjt/udns
PKG_MD5SUM:=51e141b044b078d71ebb71f823959c1b
PKG_MAINTAINER:=nanpuyue <nanpuyue@gmail.com>

include $(INCLUDE_DIR)/package.mk

define Package/udns/Default
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+libc
  URL:=http://www.corpit.ru/mjt/udns.html
  TITLE:=UDNS
  MAINTAINER:=Michael Tokarev <mjt+udns@corpit.ru>
  SUBMENU:=IP Addresses and Names
endef

define Package/libudns
  $(call Package/udns/Default)
  TITLE+= (library)
endef

define Package/libudns/description
  UDNS is a stub DNS resolver library with ability to perform both syncronous and asyncronous DNS queries.
endef

define Package/udns-utils
  $(call Package/udns/Default)
  TITLE+= (utils)
endef

export CC="$(TARGET_CC)"

define Build/Configure
	(cd $(PKG_BUILD_DIR); \
		./configure \
		--enable-ipv6 \
		--enable-cross_compile \
	)
endef
define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) all
	$(MAKE) -C $(PKG_BUILD_DIR) shared
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_BUILD_DIR)/udns.h $(1)/usr/include
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_BUILD_DIR)/lib*.{a,so*} $(1)/usr/lib
endef

define Package/libudns/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_BUILD_DIR)/lib*.so* $(1)/usr/lib
endef

define Package/udns-utils/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/{dnsget,ex-rdns,rblcheck} $(1)/usr/bin/
endef

$(eval $(call BuildPackage,libudns))
$(eval $(call BuildPackage,udns-utils))
