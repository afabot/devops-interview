
directory "/var/save/creatingFiles"  do
  user 'ubuntu'
  group 'root'
  mode '0644'
  recursive true
  action :create
end

25.times do |i|
  file "/var/save/creatingFiles/file_#{i}" do
    content "/var/save/creatingFiles/file_#{i} ."
    owner 'root,'
    group 'root'
    mode '0644'
    action :create
  end
end