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

%W(contacts commands hosts hostgroups services).each do |config_name|
  template "#{config_name}.cfg" do
    path "/etc/nagios/objects/#{config_name}.cfg"
    owner  "root"
    group  "root"
    mode   0664
    notifies :reload, 'service[nagios]'
  end
end

template 'nagios.cfg' do
  path '/etc/nagios/nagios.cfg'
  owner  "root"
  group  "root"
  mode   0664
  notifies :reload, 'service[nagios]'
end

plugins = %W(nagios-plugins nagios-plugins-disk nagios-plugins-http nagios-plugins-load nagios-plugins-mysql nagios-plugins-ping nagios-plugins-procs nagios-plugins-ssh nagios-plugins-swap nagios-plugins-users nagios-plugins-nrpe)
plugins += ((node['nagios'] && node['nagios']['plugins']) || [])
plugins.each do |plugin|
  package plugin do
    action :install
  end
end
