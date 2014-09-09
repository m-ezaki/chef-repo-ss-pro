#
# Cookbook Name:: iptables
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
service "iptables" do
 action :stop
end

template "/etc/sysconfig/iptables" do
 mode "0600"
 source "iptables.erb"
end

service "" do
 action :start
 action :enable
end
