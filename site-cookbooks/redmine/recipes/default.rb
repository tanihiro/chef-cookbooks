#
# Cookbook Name:: redmine
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

subversion 'checkout redmine' do
  repository 'http://svn.redmine.org/redmine/branches/2.3-stable'
  revision 'HEAD'
  destination '/var/www/html/redmine'
  action :checkout
  group 'app'
end

%W(libcurl-devel apr-devel apr-util-devel).each do |pkg|
  package pkg do
    action :install
  end
end
