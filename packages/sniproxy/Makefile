#
# Copyright (C) 2017 nanpuyue <nanpuyue@gmail.com>, https://blog.nanpuyue.com
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=sniproxy
PKG_VERSION:=2017-03-01
PKG_RELEASE=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/dlundquist/sniproxy.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=302b6efda9d7b3493ed1f09d8de4e75c6c004b71
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_MAINTAINER:=nanpuyue <nanpuyue@gmail.com>

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)/$(PKG_NAME)-$(PKG_VERSION)

PKG_INSTALL:=1
PKG_FIXUP:=autoreconf
PKG_USE_MIPS16:=0

include $(INCLUDE_DIR)/package.mk

define Package/sniproxy
  SECTION:=net
  CATEGORY:=Network
  TITLE:=SNI Proxy
  URL:=https://github.com/dlundquist/sniproxy
  MAINTAINER:=Dustin Lundquist <dustin@null-ptr.net>
  DEPENDS:=+libev +libpcre +libudns
endef

define Package/sniproxy/description
 Proxies incoming HTTP and TLS connections based on the hostname contained in the initial request of the TCP session.
endef

define Package/sniproxy/conffiles
/etc/sniproxy.conf
endef

TARGET_CFLAGS += \
	-std=c99 \
	-fdata-sections \
	-ffunction-sections

TARGET_LDFLAGS += \
	-Wl,-gc-sections

MAKE_FLAGS += \
	CFLAGS="$(TARGET_CFLAGS)" \
	LDFLAGS="$(TARGET_LDFLAGS)"

define Package/sniproxy/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_CONF) ./files/sniproxy.conf $(1)/etc/
	$(INSTALL_BIN) ./files/sniproxy.init $(1)/etc/init.d/sniproxy
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/sniproxy $(1)/usr/bin
endef

$(eval $(call BuildPackage,sniproxy))
