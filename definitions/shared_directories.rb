define :shared_directories, paths: [] do
  username = node.owner.username

  root = params[:name]
  root = "#{node.app.path}/#{root}" unless root.start_with?('/')

  paths = [root, "#{root}/shared"]
  paths += Array(params[:paths]).map {|p| "#{root}/shared/#{p}" }

  paths.each do |path|
    directory path do
      recursive true
      owner username
      group username
      mode 00700
    end
  end
end
