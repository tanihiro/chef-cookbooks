#
# Cookbook Name:: httpd
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'httpd' do
  action :install
end

template "httpd.conf" do
  path "/etc/httpd/conf/httpd.conf"
  owner "root"
  group "root"
  mode 0755
  notifies :reload, 'service[httpd]'
end

directory "/etc/httpd/conf/sites-available" do
  owner "root"
  group "root"
  mode 0755
  action :create
end 
directory "/etc/httpd/conf/sites-enabled" do
  owner "root"
  group "root"
  mode 0755
  action :create
end

service 'httpd' do
  action [ :enable, :start ]
  supports :status => true, :restart => true, :reload => true
end

virtualhost_ids = (node['httpd'] && node['httpd']['virtualhosts']) || []
index = 1
virtualhost_ids.each do |virtualhost_id|
  virtualhost = data_bag_item('virtualhosts', virtualhost_id)

  template "#{virtualhost['host']}.conf" do
    path "/etc/httpd/conf/sites-available/#{virtualhost['host']}.conf"
    source virtualhost['apache_source']
    owner "root"
    group "root"
    mode 0755
    notifies :reload, 'service[httpd]'
    variables({ 
      :port          => virtualhost['proxy_port'] || virtualhost['port'] || 80,
      :host          => virtualhost['host'],
      :root_path     => virtualhost['root_path'],
      :is_basic_auth => virtualhost['is_basic_auth'] || false,
      :is_ssl        => virtualhost['is_ssl'] || false
    })
  end
  
  link "/etc/httpd/conf/sites-enabled/#{sprintf('%03d', index)}-#{virtualhost['host']}.conf" do
    to "/etc/httpd/conf/sites-available/#{virtualhost['host']}.conf"
    link_type :symbolic
  end

  index+=1
end
