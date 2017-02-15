[ "mutipleCopy1", "mutipleCopy2", "mutipleCopy3" ].each do |dir|

  directory '/var/save/#{dir}' do
    recursive true
    action :delete
    ignore_failure true
  end
  directory "/var/save/#{dir}"  do
    user 'ubuntu'
    group 'root'
    mode '0644'
    recursive true
    action :create
  end
  file '/var/save/#{dir}/secret.txt' do
    content ''
    owner 'user'
    group 'root'
    mode '0644'
    action :create
  end
end