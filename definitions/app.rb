define :app, owner: nil,
             path_prefix: nil,
             paths: [:default] do
  name = params[:name]
  username = params[:owner]
  paths = Array params[:paths]
  path_prefix = params[:path_prefix]
  path_prefix = "/#{path_prefix}" if path_prefix && !path_prefix.start_with?('/')
  shared_path = "shared#{path_prefix}"

  if paths.include? :default
    paths.delete :default
    paths += ['releases',
              'shared']
    paths << shared_path if path_prefix
    paths += ["#{shared_path}/config",
              "#{shared_path}/log",
              "#{shared_path}/tmp"]
  end

  root = "#{node.app.path}/#{name}"

  directory root do
    owner username
    group username
    mode 00700
    recursive true
  end

  paths.each do |dir|
    directory "#{root}/#{dir}" do
      recursive true
      owner username
      group username
      mode 00700
    end
  end
end
