#
# Cookbook Name:: munin
# Recipe:: master
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute 'clean-default-plugins' do
  command "rm -f /etc/munin/plugins/*"
  action :nothing
end

execute 'clean-httpd-conf' do
  command "rm -f /etc/httpd/conf.d/munin.conf"
  action :nothing
end

package 'munin' do
  action :install
  notifies :run, "execute[clean-default-plugins]", :immediately
  notifies :run, "execute[clean-httpd-conf]", :immediately
end

template "munin.conf" do
  path "/etc/munin/munin.conf"
  owner "root"
  group "root"
  mode 0755
end
