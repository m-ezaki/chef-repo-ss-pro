#
# Cookbook Name:: rsyslog
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template "/etc/rsyslog.conf" do
 mode 0644
 source "rsyslog.conf.erb"
end

service "rsyslog" do
  action :enable
  action :restart
end
