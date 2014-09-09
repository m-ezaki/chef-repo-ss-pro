#
# Cookbook Name:: mysql56u_after_install
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#mysql-libをアンインストールした際依存関係で削除されたプログラムを再度インストール
%w{crontabs cronie cronie-anacron postfix}.each do |pkg|
 package pkg do
  action :install
 end
end
