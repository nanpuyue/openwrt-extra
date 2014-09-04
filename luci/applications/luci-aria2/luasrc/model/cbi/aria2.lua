--[[
LuCI - Lua Configuration Interface - Aria2 support

Copyright 2014 nanpuyue <nanpuyue@gmail.com>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0
]]--

require("luci.sys")
require("luci.util")
require("luci.model.ipkg")

local webui="yaaw"
local uci = require "luci.model.uci".cursor()
local running = (luci.sys.call("pidof aria2c > /dev/null") == 0)
local webinstalled = luci.model.ipkg.installed(webui) 
local button = ""
if running and webinstalled then
	button = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=\"button\" value=\" " .. translate("Open Web Interface") .. " \" onclick=\"window.open('/" .. webui .. "')\"/>"
end

m = Map("aria2", translate("Aria2 Settings"), translate("Aria2 is a multi-protocol &amp; multi-source download utility, here you can configure the settings.") .. button)

s=m:section(TypedSection, "aria2", translate("Global settings"))
s.addremove=false
s.anonymous=true
enable=s:option(Flag, "enabled", translate("Enabled"))
enable.rmempty=false
user=s:option(ListValue, "user", translate("Run daemon as user"))
local p_user
for _, p_user in luci.util.vspairs(luci.util.split(luci.sys.exec("cat /etc/passwd | cut -f 1 -d :"))) do
	user:value(p_user)
end

file=m:section(TypedSection, "aria2", translate("Files and Locations"))
file.anonymous=true
config_dir=file:option(Value, "config_dir", translate("Config file directory"))
config_dir.placeholder="/var/etc/aria2"
dir=file:option(Value, "dir", translate("Default download directory"))
disk_cache=file:option(Value, "disk_cache", translate("Disk cache"), translate("in bytes, You can append K or M"))
file_allocation=file:option(ListValue, "file_allocation", translate("Preallocation"), translate("\"falloc\" is not available in all cases"))
file_allocation:value("none", translate("off"))
file_allocation:value("prealloc", translate("prealloc"))
file_allocation:value("trunc", translate("trunc"))
file_allocation:value("falloc", translate("falloc"))

task=m:section(TypedSection, "aria2", translate("Task Settings"))
task.anonymous=true
overall_speed_limit=task:option(Flag, "overall_speed_limit", translate("Overall speed limit enabled"))
max_overall_download_limit=task:option(Value, "max_overall_download_limit", translate("Overall download limit"), translate("in bytes/sec, You can append K or M"))
max_overall_download_limit:depends("overall_speed_limit", "1")
max_overall_upload_limit=task:option(Value, "max_overall_upload_limit", translate("Overall upload limit"), translate("in bytes/sec, You can append K or M"))
max_overall_upload_limit:depends("overall_speed_limit", "1")
task_speed_limit=task:option(Flag, "task_speed_limit", translate("Per task speed limit enabled"))
max_download_limit=task:option(Value, "max_download_limit", translate("Per task download limit"), translate("in bytes/sec, You can append K or M"))
max_download_limit:depends("task_speed_limit", "1")
max_upload_limit=task:option(Value, "max_upload_limit", translate("Per task upload limit"), translate("in bytes/sec, You can append K or M"))
max_upload_limit:depends("task_speed_limit", "1")
max_concurrent_downloads=task:option(Value, "max_concurrent_downloads", translate("Max concurrent downloads"))
max_concurrent_downloads.placeholder="5"
max_connection_per_server=task:option(Value, "max_connection_per_server", translate("Max connection per server"), "1-16")
max_connection_per_server.datetype="range(1, 16)"
max_connection_per_server.placeholder="1"
min_split_size=task:option(Value, "min_split_size", translate("Min split size"), "1M-1024M")
min_split_size.placeholder="20M"
split=task:option(Value, "split", translate("Max number of split"))
split.placeholder="5"
save_session_interval=task:option(Value, "save_session_interval", translate("Autosave session interval"), translate("Sec"))
save_session_interval.default="30"

bittorrent=m:section(TypedSection, "aria2", translate("BitTorrent Settings"))
bittorrent.anonymous=true
enable_dht=bittorrent:option(Flag, "enable_dht", translate("<abbr title=\"Distributed Hash Table\">DHT</abbr> enabled"))
enable_dht.enabled="true"
enable_dht.disabled="false"
bt_enable_lpd=bittorrent:option(Flag, "bt_enable_lpd", translate("<abbr title=\"Local Peer Discovery\">LPD</abbr> enabled"))
bt_enable_lpd.enabled="true"
bt_enable_lpd.disabled="false"
follow_torrent=bittorrent:option(Flag, "follow_torrent", translate("Follow torrent"))
follow_torrent.enabled="true"
follow_torrent.disabled="false"
listen_port=bittorrent:option(Value, "listen_port", translate("BitTorrent listen port"))
listen_port.placeholder="6881-6999"
bt_max_peers=bittorrent:option(Value, "bt_max_peers", translate("Max number of peers per torrent"))
bt_max_peers.placeholder="55"
bt_tracker_enable=bittorrent:option(Flag, "bt_tracker_enable", translate("Additional Bt tracker enabled"))
bt_tracker=bittorrent:option(DynamicList, "bt_tracker", translate("List of additional Bt tracker"))
bt_tracker:depends("bt_tracker_enable", "1")
bt_tracker.rmempty=true

function bt_tracker.cfgvalue(self, section)
	local rv = { }

	local val = Value.cfgvalue(self, section)
	if type(val) == "table" then
		val = table.concat(val, ",")
	elseif not val then
		val = ""
	end

	for v in val:gmatch("[^,%s]+") do
		rv[#rv+1] = v
	end

	return rv
end

function bt_tracker.write(self, section, value)
	local rv = { }
	for v in luci.util.imatch(value) do
		rv[#rv+1] = v
	end
	Value.write(self, section, table.concat(rv, ","))
end

rpc=m:section(TypedSection, "aria2", translate("RPC settings"))
rpc.anonymous=true
rpc_listen_port=rpc:option(Value, "rpc_listen_port", translate("RPC port"))
rpc_listen_port.datatype="port"
rpc_listen_port.placeholder="6800"
rpc_auth_required=rpc:option(Flag, "rpc_auth_required", translate("RPC authentication required"))
rpc_user=rpc:option(Value, "rpc_user", translate("RPC username"))
rpc_user:depends("rpc_auth_required", "1")
rpc_passwd=rpc:option(Value, "rpc_passwd", translate("RPC password"))
rpc_passwd:depends("rpc_auth_required", "1")
rpc_passwd.password = true

return m
