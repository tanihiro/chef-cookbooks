#
# Cookbook Name:: os-defaults
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# 必要なコンパイラなどをインストール   
%w{gcc gcc-c++ make libxml2 libxml2-devel libxslt libxslt-devel openssl-devel zlib-devel}.each do |pkg|
  package pkg do
    action :install
  end
end

## 不要な各種サービスを停止する
%W(acpid apmd autofs avahi-daemon avahi-dnsconfd bluetooth cups gpm haldaemon hidd ip6tables kudzu mcstrans mdmonitor microcode_ctl netfs nfslock pcscd portmap readahead_early restorecond rpcgssd rpcidmapd smartd xfs).each do |name|
  service name do
    action [ :disable, :stop ]
  end
end

cookbook_file "/etc/sysconfig/clock" do
  owner "root"
  mode 0644
end


link "/etc/localtime" do
  to "/usr/share/zoneinfo/Japan"
end
