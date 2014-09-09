#
# Cookbook Name:: yum-idcf
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

remote_file "/etc/yum.repos.d/IDCF.repo" do
 source "http://repo.cloud.idc.jp/Linux/CentOS/IDCF.repo"
end

