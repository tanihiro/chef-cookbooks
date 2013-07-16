#
# Cookbook Name:: iptables
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'iptables' do
  action :install
end

service 'iptables' do
  supports :restart => true
  action [:enable, :restart]
end

template "iptables.conf" do
  path "/etc/sysconfig/iptables"
  owner "root"
  group "root"
  mode 0600
  notifies :restart, "service[iptables]"
end
