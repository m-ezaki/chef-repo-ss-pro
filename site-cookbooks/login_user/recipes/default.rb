data = data_bag('users')

data.each do |id|

 u = data_bag_item('users',id)
 
 group u['group'] do
  gid u['gid']
  action [:create]
 end

 user u['username'] do
  uid u['uid']
  group u['group']
  password u['password']
  home u['home']
  shell u['shell']
  supports :manage_home => true
  action [:create, :manage]
 end

end 

directory '/home/gn25-admin/.ssh' do
 owner 'gn25-admin'
 group 'gn25-admin'
 mode '0700'
 action :create
end
 
template "/home/gn25-admin/.ssh/authorized_keys" do
 owner 'gn25-admin'
 group 'gn25-admin'
 mode "0600"
 source "authorized_keys.erb"
end

template "/home/gn25-admin/.ssh/id_rsa" do
 owner 'gn25-admin'
 group 'gn25-admin'
 mode "0600"
 source "id_rsa.erb"
end

template "/etc/sudoers" do
 owner 'root'
 group 'root'
 mode '0440'
 source 'sudoers.erb'
end
