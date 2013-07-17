#
# Cookbook Name:: rbenv
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

user_name = node['rbenv']['user']
home = "/home/#{user_name}"

git "#{home}/.rbenv" do
  repository 'git://github.com/sstephenson/rbenv.git'
  reference 'master'
  action :checkout
  user user_name
  group user_name
end

bash "set bashrc" do
  user user_name
  cwd home
  environment "HOME" => home
  
  code <<-EOC
   echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
   echo 'eval "$(rbenv init -)"' >> ~/.bashrc
   source ~/.bashrc 
  EOC
  not_if "cat #{home}/.bashrc | grep rbenv" 
end

directory "#{home}/.rbenv/plugins" do
  owner user_name
  group user_name
  mode 0755
  action :create
end

git "#{home}/.rbenv/plugins/ruby-build" do
  repository 'git://github.com/sstephenson/ruby-build.git'
  reference 'master'
  action :checkout
  user  user_name
  group user_name
end

versions = (node['rbenv']['versions'] || [])
versions.each do |version|
  execute "install ruby #{version}" do
    command "su #{user_name} -l -c 'rbenv install #{version}'"
    not_if "su #{user_name} -l -c 'rbenv versions' | grep #{version}" 
  end
end

execute "global version" do
    command "su #{user_name} -l -c 'rbenv global #{versions.first}'"
end
