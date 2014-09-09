#
# Cookbook Name:: before_install
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{mysql-libs}.each do |pkg|
 package pkg do
  action :remove
 end
end

#入っていれば消す
%w{mysql-community-server
 mysql-community-libs
 mysql-community-libs-compat
 mysql-community-common 
 }.each do |pkg|
 package pkg do
  action :remove
 end
end
