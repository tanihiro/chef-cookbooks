#
# Cookbook Name:: redis
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'redis' do
  action :install
end

service 'redis' do
  action [ :enable, :start ]
  supports :status => true, :restart => true 
end

template 'redis.conf' do
  path '/etc/redis.conf'
  owner "root"
  group "root"
  mode 0755
  notifies :restart, 'service[redis]'
end
