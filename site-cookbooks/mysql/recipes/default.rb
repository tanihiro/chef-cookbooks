#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{mysql mysql-devel mysql-server}.each do |pkg|
  package pkg do
    action :install
  end
end

service 'mysqld' do
  action [ :enable, :start ]
  supports :status => true, :restart => true, :reload => true
end
