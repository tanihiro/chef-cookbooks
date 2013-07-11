#
# Cookbook Name:: users
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

user_ids = data_bag('users')

user_ids.each do |user_id|
  u = data_bag_item('users', user_id)
  name     = u['id']
  password = u['password']
  shell    = u['shell'] || '/bin/bash'
  home     = "/home/#{name}"

  user name do
    home home
    shell shell
    password password
    action :create
    supports :manage_home => true
  end
  
  group "wheel" do
    action [:modify]
    members [name]
    append true
  end
end
