OpenWrt-Extra
=============

Some extra packages for OpenWrt

Add "src-git extra git://github.com/nanpuyue/openwrt-extra.git" to feeds.conf.default.

```bash
./scripts/feeds update -a
./scripts/feeds install -a
```

the list of packages:
* luci-app-aira2 (make package/feeds/extra/luci-extra)
* yaaw (make package/feeds/extra/yaaw)
* dnscrypt-proxy (make package/feeds/extra/dnscrypt-proxy)
* libsodium (depended by dnscrypt-proxy, but have no ipk)
