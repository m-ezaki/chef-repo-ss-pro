#
# Cookbook Name:: zabbix-agent
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
##require "ohai"
host_address_val = node[:network][:interfaces][:eth1][:addresses].select { |address, data| data[:family] == "inet" }
host_address_array = host_address_val.keys

remote_file "/tmp/zabbix-jp-release-6-6.noarch.rpm" do
 source "http://repo.zabbix.jp/relatedpkgs/rhel6/x86_64/zabbix-jp-release-6-6.noarch.rpm"
end

package "zabbix-agent-release-centos" do
 action :install
 source "/tmp/zabbix-jp-release-6-6.noarch.rpm"
 provider Chef::Provider::Package::Rpm
end

package "zabbix-agent" do
  action :install
end

template "/etc/zabbix/zabbix_agentd.conf" do
 mode 0644
 source "zabbix_agentd.conf.erb"
## oh = Ohai::System.new
## oh.all_plugins
## host_address_val = oh["network"]["interfaces"]["eth1"]["addresses"].select { |address, data| data["family"] == "inet" }
## host_address_array = host_address_val.keys
 
 variables({
   :zabbix_agent_address => host_address_array[0]
 })

end

directory "/etc/zabbix/zabbix_agentd.d" do
 owner "root"
 group "root"
 recursive true
 mode 0644
 action :create
 not_if "ls -d /etc/zabbix/zabbix_agentd.d"
end

directory "/etc/zabbix/mysql" do
 owner "root"
 group "root"
 recursive true
 mode 0644
 action :create
 not_if "ls -d /etc/zabbix/mysql"
end

template "/etc/zabbix/zabbix_agentd.d/userparameter_mysql.conf" do
 mode 0644
 source "userparameter_mysql.conf.erb"
end

template "/etc/zabbix/mysql/my.cnf" do
 mode 0644
 source "my.cnf.erb"
end

template "/etc/httpd/conf.d/zabbix_apache_status.conf" do
 mode 0644
 source "zabbix_apache_status.conf.erb"
end

service "zabbix-agent" do
 action [:nothing]
end
