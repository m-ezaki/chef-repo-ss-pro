
# Cookbook Name:: td-agent
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

group 'td-agent' do
  group_name 'td-agent'
  gid        403
  action     [:create]
end

user 'td-agent' do
 comment 'td-agent'
 uid     403
 group   'td-agent'
 home    '/var/run/td-agent'
 shell   '/bin/false'
 password nil
 supports :manage_home => true
 action [:create, :manage]
end

directory '/etc/td-agent/' do
 owner 'td-agent'
 group 'td-agent'
 mode  '0755'
 action :create
end

case node['platform']
when "ubuntu"
 dist = node['lsb']['codename']
 source = (dist == 'precise')?
"http://package.treasure-data.com/precise/":
"http://package.treasure-data.com/debian/"
 apt_repository "treasure-data" do
  uri source
  distribution dist
  components ["contrib"]
  action :add
 end
when "centos","redhat"
 yum_repository "treasure-data" do
  url "http://packages.treasure-data.com/redhat/$basearch"
  action :add
 end
end

template "/etc/td-agent/td-agent.conf" do
 mode "0644"
 source "td-agent.conf.erb"
end

package "td-agent" do
 action :install
end
