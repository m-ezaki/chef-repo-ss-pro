#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# mysql56をインストールする前にインストールされているデフォルトのmysqlを削除する
#bash 'remove_installed_mysql' do
#  only_if 'yum list installed | grep ^mysql-*'
#  user 'root'
#  code <<-EOL
#    yum remove -y mysql-*
#  EOL
#end

%w{mysql56u mysql56u-common}.each do |pkg|
  package pkg do
   action :install
  end
end

%w{mysql56u-bench mysql56u-devel
  mysql56u-libs mysql56u-server}.each do |pkg|
  package pkg do
    action :install
  end
end

template "/etc/my.cnf" do
 mode "0644"
 source "my.cnf.erb"
end

service "mysqld" do
 action [:nothing]
end
