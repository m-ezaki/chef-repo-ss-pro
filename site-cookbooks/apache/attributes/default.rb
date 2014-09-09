default['apache'][:app_domain] = "hogehoge"
default['apache'][:app_documentroot] = "/home/#{node['apache'][:app_domain]}/html"