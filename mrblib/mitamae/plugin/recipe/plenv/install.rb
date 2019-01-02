include_recipe 'plenv::dependencies'

scheme     = node[:plenv][:scheme]
plenv_root = node[:plenv][:plenv_root]

git plenv_root do
  repository "#{scheme}://github.com/tokuhirom/plenv.git"
  user node[:plenv][:user] if node[:plenv][:user]
end

directory File.join(plenv_root, 'plugins') do
  user node[:plenv][:user] if node[:plenv][:user]
end

git "#{plenv_root}/plugins/perl-build" do
  repository "#{scheme}://github.com/tokuhirom/Perl-Build.git"
  user node[:plenv][:user] if node[:plenv][:user]
end

plenv_init = <<-EOS
  export PLENV_ROOT=#{plenv_root}
  export PATH="#{plenv_root}/bin:${PATH}"
  eval "$(plenv init -)"
EOS

node[:plenv][:versions].each do |version|
  execute "plenv install #{version}" do
    command "#{plenv_init} plenv install #{version}"
    not_if  "#{plenv_init} plenv versions | grep #{version}"
    user node[:plenv][:user] if node[:plenv][:user]
  end
end

if node[:plenv][:global]
  node[:plenv][:global].tap do |version|
    execute "plenv global #{version}" do
      command "#{plenv_init} plenv global #{version}"
      not_if  "#{plenv_init} plenv version | grep #{version}"
      user node[:plenv][:user] if node[:plenv][:user]
    end
  end
end
