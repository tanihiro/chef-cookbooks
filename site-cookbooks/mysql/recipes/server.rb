#
# Cookbook Name:: mysql
# Recipe:: server
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'mysql-server' do
  action :install
end

service 'mysqld' do
  action [ :enable, :start ]
  supports :status => true, :restart => true, :reload => true
end

