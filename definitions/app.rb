define :app, owner: nil,
             paths: [] do
  name = params[:name]
  username = params[:owner]
  paths = Array params[:paths]

  directory "#{node.app.path}/#{name}/releases" do
    owner username
    group username
    mode 00700
    recursive true
  end

  shared_directories name do
    send :paths, paths
  end
end
