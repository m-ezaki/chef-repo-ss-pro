#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
host_address_val = node[:network][:interfaces][:eth0][:addresses].select { |address, data| data[:family] == "inet" }
host_address_array = host_address_val.keys

package "httpd" do
 action :install
end

directory "/home/#{node['apache'][:app_domain]}/html" do
 owner 'root'
 group 'root'
 mode '0655'
 recursive true
 action :create
end

template "/etc/httpd/conf/httpd.conf" do
 mode 0644
 source "httpd.conf.erb"
 variables({
   :apache_service_ipaddress => host_address_array[0]
 })
end

template "/etc/httpd/conf.d/sysmgmt.conf" do
 mode 0644
 source "sysmgmt.conf.erb"
end

service "httpd" do
 action :nothing
end
