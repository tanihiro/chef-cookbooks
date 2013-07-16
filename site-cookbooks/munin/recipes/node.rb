#
# Cookbook Name:: munin
# Recipe:: node
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'munin-node' do
  action :install
end

service 'munin-node' do
  action [ :enable, :start ]
  supports :status => true, :restart => true, :reload => true
end

template 'munin-node.conf' do
  path "/etc/munin/munin-node.conf"
  owner "root"
  group "root"
  mode 0755
end
