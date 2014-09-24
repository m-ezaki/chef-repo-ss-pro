#
# Cookbook Name:: zabbix-agent
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
##require "ohai"

# ethのaddressに関する値をohaiで取得。※eth毎のIPアドレスはkeyで持っている為、keyをarrayに入れなおす。
host_address_val = node[:network][:interfaces][:eth1][:addresses].select { |address, data| data[:family] == "inet" }
host_address_array = host_address_val.keys

# リポジトリのrpmを取得
remote_file "/tmp/zabbix-jp-release-6-6.noarch.rpm" do
 source "http://repo.zabbix.jp/relatedpkgs/rhel6/x86_64/zabbix-jp-release-6-6.noarch.rpm"
end

# リポジトリのrpmを適用
package "zabbix-agent-release-centos" do
 action :install
 source "/tmp/zabbix-jp-release-6-6.noarch.rpm"
 provider Chef::Provider::Package::Rpm
end

# インストール
package "zabbix-agent" do
  action :install
end

# zabbixエージェント設定ファイルを配布
template "/etc/zabbix/zabbix_agentd.conf" do
 mode 0644
 source "zabbix_agentd.conf.erb"
## oh = Ohai::System.new
## oh.all_plugins
## host_address_val = oh["network"]["interfaces"]["eth1"]["addresses"].select { |address, data| data["family"] == "inet" }
## host_address_array = host_address_val.keys

 # ethのIPアドレスをテンプレ内で参照可能とする
 variables({
   :zabbix_agent_address => host_address_array[0]
 })

end

# zabbix設定サブディレクトリを作成
directory "/etc/zabbix/zabbix_agentd.d" do
 owner "root"
 group "root"
 recursive true
 mode 0644
 action :create
 not_if "ls -d /etc/zabbix/zabbix_agentd.d"
end

# 起動は手動で行う
service "zabbix-agent" do
 action [:nothing]
end
