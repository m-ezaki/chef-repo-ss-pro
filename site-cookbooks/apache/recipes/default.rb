#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2014,
#
# All rights reserved - Do Not Redistribute
#

# ethのaddressに関する値をohaiで取得。※eth毎のIPアドレスはkeyで持っている為、keyをarrayに入れなおす。
host_address_val = node[:network][:interfaces][:eth0][:addresses].select { |address, data| data[:family] == "inet" }
host_address_array = host_address_val.keys

# apacheをインストール
package "httpd" do
 action :install
end

#　ドキュメントルートディレクトリを作成　※app_domainのattributeは適宜書き換える。
directory "/home/#{node['apache'][:app_domain]}/html" do
 owner 'root'
 group 'root'
 mode '0655'
 recursive true
 action :create
end

#　httpd.confを配布
template "/etc/httpd/conf/httpd.conf" do
 mode 0644
 source "httpd.conf.erb"
 # ethのIPアドレスをテンプレ内で参照可能とする
 variables({
   :apache_service_ipaddress => host_address_array[0]
 })
end

# lvsのヘルスチェック用ファイルを配布
template "/etc/httpd/conf.d/sysmgmt.conf" do
 mode 0644
 source "sysmgmt.conf.erb"
end

# server_status設定を配布。主にzabbixの外部スクリプトから利用
template "/etc/httpd/conf.d/zabbix_apache_status.conf" do
 mode 0644
 source "zabbix_apache_status.conf.erb"
end

# 起動は手動で行う
service "httpd" do
 action :nothing
end
