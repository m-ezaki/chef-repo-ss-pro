#
# Cookbook Name:: php54-fpm
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{php54-fpm}.each do |pkg|
 package pkg do
  action :install
 end
end
