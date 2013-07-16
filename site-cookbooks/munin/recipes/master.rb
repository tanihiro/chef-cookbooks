#
# Cookbook Name:: munin
# Recipe:: master
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'munin' do
  action :install
end

template "munin.conf" do
  path "/etc/munin/munin.conf"
  owner "root"
  group "root"
  mode 0755
end
