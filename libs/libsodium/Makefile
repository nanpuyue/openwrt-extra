#
# Copyright (C) 2014 nanpuyue <nanpuyue@gmail.com>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libsodium
PKG_VERSION:=0.4.5
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=git://github.com/jedisct1/libsodium.git
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=0.4.5

PKG_MAINTAINER:=nanpuyue <nanpuyue@gmail.com>

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/libsodium
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=Portable & packageable NaCl-based crypto library
  URL:=https://github.com/jedisct1/libsodium
  MENU:=1
endef

define Package/libsodium/description
	NaCl (pronounced "salt") is a new easy-to-use high-speed software library for network communication, encryption, decryption, signatures, etc.
	NaCl's goal is to provide all of the core operations needed to build higher-level cryptographic tools.
	Sodium is a portable, cross-compilable, installable, packageable fork of NaCl, with a compatible API.
endef

CONFIGURE_ARGS += \
	--prefix=/usr \
	--disable-shared \
	--enable-static \

define Build/Configure
	$(call Build/Configure/Default)
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/* $(1)/usr/include/

	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libsodium.a $(1)/usr/lib/
endef

$(eval $(call BuildPackage,libsodium))
