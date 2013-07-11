#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'nginx' do
  action :install
end

service 'nginx' do
  action [ :enable, :start ]
  supports :status => true, :restart => true, :reload => true
end

template "nginx.conf" do
  path "/etc/nginx/nginx.conf"
  owner "root"
  group "root"
  mode 0755
  notifies :reload, 'service[nginx]'
end

directory "/etc/nginx/sites-available" do
  owner "root"
  group "root"
  mode 0755
  action :create
end

directory "/etc/nginx/sites-enabled" do
  owner "root"
  group "root"
  mode 0755
  action :create
end

virtualhost_ids = data_bag('virtualhosts')
index = 1
virtualhost_ids.each do |virtualhost_id|
puts virtualhost_id
  virtualhost = data_bag_item('virtualhosts', virtualhost_id)
  puts virtualhost

  template "#{virtualhost['host']}.conf" do
    path   "/etc/nginx/sites-available/#{virtualhost['host']}.conf"
    source "#{virtualhost['framework']}.virtualhost.conf.erb"
    owner  "root"
    group  "root"
    mode 0755
    notifies :reload, 'service[nginx]'
    variables(
      :port              => virtualhost['port'] || 80,
      :proxy_port        => virtualhost['proxy_port'] || 8080,
      :host              => virtualhost['host'],
      :root_path         => virtualhost['root_path'],
      :keepalive_timeout => virtualhost['keepalive_timeout'] || 5,
      :is_basic_auth     => virtualhost['is_basic_auth'] || false,
      :is_ssl            => virtualhost['is_ssl'] || false
    )
  end
  
  link "/etc/nginx/sites-enabled/#{sprintf('%03d', index)}-#{virtualhost['host']}.conf" do
    to "/etc/nginx/sites-available/#{virtualhost['host']}.conf"
    link_type :symbolic
  end

  index+=1
end
