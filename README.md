OpenWrt-Extra
=============

Some extra packages for OpenWrt

Add "src-git extra git://github.com/nanpuyue/openwrt-extra.git" to feeds.conf.default.

```bash
./scripts/feeds update -a
./scripts/feeds install -a
```

the list of packages:
* luci-app-aira2
* yaaw
* dnscrypt-proxy
* libsodium (depended by dnscrypt-proxy, but have no ipk)
* shadowsocks-libev
