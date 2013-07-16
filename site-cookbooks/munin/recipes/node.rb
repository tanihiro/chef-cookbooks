#
# Cookbook Name:: munin
# Recipe:: node
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute 'clean-default-plugins' do
  command "rm -f /etc/munin/plugins/*"
  action :nothing
end

package 'munin-node' do
  action :install
  notifies :run, "execute[clean-default-plugins]", :immediately
end

# default plugins
plugins = {}
plugins['list'] = %W(cpu cpuspeed diskstats diskstats memory load)
plugins['if_']  = %W(if_eth0 if_eth1)
plugins['if_err_'] = %W(if_err_eth0 if_err_eth1)

plugin_packages = ((node['munin'] && node['munin']['node_plugin'] && node['munin']['node_plugin']['packages']) || [])

# mysql plugins
unless plugin_packages.index('mysql') === nil
  plugins['list'] += %W(mysql_ mysql_bytes mysql_innodb mysql_queries mysql_slowqueries mysql_threads)
  plugins['mysql_'] = %W(mysql_bin_relay_log mysql_innodb_bpool_act mysql_innodb_rows mysql_qcache mysql_sorts mysql_commands mysql_innodb_insert_buf mysql_innodb_semaphores mysql_qcache_mem mysql_table_locks mysql_connections mysql_innodb_io mysql_innodb_tnx mysql_replication mysql_tmp_tables mysql_files_tables mysql_innodb_io_pend mysql_select_types mysql_innodb_bpool mysql_innodb_log mysql_network_traffic mysql_slow)
end

# apache plugins
unless plugin_packages.index('apache') === nil
  plugins['list'] += %W(apache_accesses apache_processes apache_volume)
end

# nginx plugins
unless plugin_packages.index('nginx') === nil
  plugins['list'] += %W(nginx_request nginx_status)
end

plugins['list'] += ((node['munin'] && node['munin']['node_plugin'] && node['munin']['node_plugin']['list']) || [])

plugins.each do |key, names|
  names.each do |name|
    plugin_name = key === 'list' ? name : key
    link "/etc/munin/plugins/#{name}" do
      to "/usr/share/munin/plugins/#{plugin_name}"
      owner 'root'
      group 'root'
      notifies :restart, 'service[munin-node]'
    end
  end
end

service 'munin-node' do
  action [ :enable, :start ]
  supports :status => true, :restart => true, :reload => true
end

template 'munin-node.conf' do
  path "/etc/munin/munin-node.conf"
  owner "root"
  group "root"
  mode 0755
end

template 'plugin-conf.d/munin-node' do
  path "/etc/munin/plugin-conf.d/munin-node"
  source 'plugin-conf.d/munin-node.erb'
  owner "root"
  group "root"
  mode 0755
end
