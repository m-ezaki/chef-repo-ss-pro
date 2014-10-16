#
# Cookbook Name:: yum-adtech
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#リポジトリのrpmを取得

remote_file "/tmp/CentOS-adtech-release-centos-6-0.el6.0.13.noarch.rpm" do
 source "http://yum001.infra.adtech.local/adtech-coresys/centos/6/x86_64/CentOS-adtech-release-centos-6-0.el6.0.13.noarch.rpm"
end

package "CentOS-adtech-release-centos.noarch" do
 action :install
 source "/tmp/CentOS-adtech-release-centos-6-0.el6.0.13.noarch.rpm"
 provider Chef::Provider::Package::Rpm
end
