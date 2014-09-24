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

# インストール１
%w{mysql56u mysql56u-common}.each do |pkg|
  package pkg do
   action :install
  end
end

# インストール２
%w{mysql56u-bench mysql56u-devel
  mysql56u-libs mysql56u-server}.each do |pkg|
  package pkg do
    action :install
  end
end

# 設定ファイル配布
template "/etc/my.cnf" do
 mode "0644"
 source "my.cnf.erb"
end

# mysqlのzabbixユーザ認証ファイル格納ディレクトリ
directory "/etc/zabbix/mysql" do
 owner "root"
 group "root"
 recursive true
 mode 0644
 action :create
 not_if "ls -d /etc/zabbix/mysql"
end

# mysqlのzabbixユーザ認証ファイル配布
template "/etc/zabbix/mysql/zabbix_my.cnf" do
 mode 0644
 source "zabbix_my.cnf.erb"
end

# mysql用zabbixユーザパラメータ配布
template "/etc/zabbix/zabbix_agentd.d/userparameter_mysql.conf" do
 mode 0644
 source "userparameter_mysql.conf.erb"
end

# 起動は手動
service "mysqld" do
 action [:nothing]
end
