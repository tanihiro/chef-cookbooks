#
# Cookbook Name:: nagios
# Recipe:: master
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute 'clean-httpd-conf' do
  command "rm -f /etc/httpd/conf.d/nagios.conf"
  action :nothing
end

package 'nagios' do
  action :install
  notifies :run, "execute[clean-httpd-conf]", :immediately
end

service 'nagios' do
  action [ :enable, :start ]
  supports :status => true, :restart => true, :reload => true
end

template 'contacts.cfg' do
  path '/etc/nagios/objects/contacts.cfg'
  owner  "root"
  group  "root"
  notifies :reload, 'service[nagios]'
end

template 'hosts.cfg' do
  path '/etc/nagios/objects/hosts.cfg'
  owner  "root"
  group  "root"
  notifies :reload, 'service[nagios]'
end

template 'hostgroups.cfg' do
  path '/etc/nagios/objects/hostgroups.cfg'
  owner  "root"
  group  "root"
  notifies :reload, 'service[nagios]'
end

template 'services.cfg' do
  path '/etc/nagios/objects/services.cfg'
  owner  "root"
  group  "root"
  notifies :reload, 'service[nagios]'
end
