#
# Cookbook Name:: php
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'php' do
  action :install
end

# default library
default = %W(php-mbstring php-pdo php-mysql php-pecl-xdebug)
modules = default + ((node['php'] && node['php']['modules']) || [])
modules.each do |mdl|
  package mdl do
    action :install
  end
end
