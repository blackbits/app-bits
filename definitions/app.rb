define :app, owner: nil, paths: [:default] do
  name = params[:name]
  username = params[:owner]
  paths = Array params[:paths]

  if paths.include? :default
    paths.delete :default
    paths += ['releases',
              'shared',
              'shared/config',
              'shared/log',
              'shared/tmp']
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
