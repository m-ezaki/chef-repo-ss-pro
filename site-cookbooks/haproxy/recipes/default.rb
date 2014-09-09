#
# Cookbook Name:: haproxy
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "haproxy" do
 action :install
end

package "socat" do
 action :install
end

template "/etc/haproxy/haproxy.cfg" do
 mode 0644
 source "haproxy.cfg.erb"
end

service "haproxy" do
 action [:nothing]
end
