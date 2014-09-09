#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
log "nginx installation start !!"

remote_file "/tmp/nginx-release-centos-6-0.el6.ngx.noarch.rpm" do
 source "http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm"
end 

package "nginx-release-centos" do
 action :install
 source "/tmp/nginx-release-centos-6-0.el6.ngx.noarch.rpm"
 provider Chef::Provider::Package::Rpm
end

package "nginx" do
  action :install
end

directory "/var/www/html/HealthCheckMonitor/sysmgmt" do
 owner "root"
 group "root"
 recursive true
 mode 0644
 action :create
 not_if "ls -d /var/www/html/HealthCheckMonitor/sysmgmt"
 #not_if { File.exists "/var/www/html" }
end

bash "add hostname" do
  not_if "ls /var/www/html/HealthCheckMonitor/sysmgmt/index.html"

  code <<-EOC
    hostname >> /var/www/html/HealthCheckMonitor/sysmgmt/index.html
  EOC
end

template "/etc/nginx/nginx.conf" do
 mode 0644
 source "nginx.conf.erb"
end

template "/etc/nginx/conf.d/default.conf" do
 mode 0644
 source "default.conf.erb"
end

template "/var/www/html/index.php" do
 mode 0644
 source "index.php.erb"
end

template "/var/www/html/test.php" do
 mode 0644
 source "test.php.erb"
end

service "nginx" do
 action [:nothing]
end
