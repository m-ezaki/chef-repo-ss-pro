#
# Cookbook Name:: php54
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{php54 php54-cli php54-common}.each do |pkg|
 package pkg do
  action :install
 end
end

%w{php54-cli php54-pdo php54-cgi php54-devel php54-mysql
php54-gd php54-mbstring php54-pear php54-pecl-apc 
php54-mcrypt php54-pecl-memcached}.each do |pkg|
 package pkg do
  action :install
 end
end

%w{php54-fpm}.each do |pkg|
 package pkg do
  action :install
 end
end
