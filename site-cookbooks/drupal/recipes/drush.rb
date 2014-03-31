#
# Cookbook Name:: drupal
# Recipe:: drush
#
# Copyright 2014, Angry Cactus

include_recipe 'git'
include_recipe 'composer'

git node['drush']['install_dir'] do
    repository "https://github.com/drush-ops/drush.git"
    reference node['drush']['version']
    action :sync
end

link "/usr/bin/drush" do
    to "#{node['drush']['install_dir']}/drush"
end

execute 'composer install' do
    cwd node['drush']['install_dir']
end

# php_pear is only working for PECL packages
execute "pear upgrade Console_Table"

directory "/etc/drush" do
    owner "root"
    group "root"
    mode 0755
    action :create
end

