#
# Cookbook Name:: nagios
# Recipe:: nrpe
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'nagios-nrpe' do
  action :install
end

service 'nrpe' do
  action [ :enable, :start ]
  supports :status => true, :restart => true, :reload => true
end

template 'nrpe.cfg' do
  path '/etc/nagios/nrpe.cfg'
  owner  "root"
  group  "root"
  notifies :reload, 'service[nrpe]'
end

