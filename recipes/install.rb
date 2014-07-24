#
# Cookbook Name:: php-fpm
# Recipe:: install
#
# Copyright 2014, Stajkowski
#
# All rights reserved - Do Not Redistribute
#
#     _       _       _       _       _       _       _    
#   _( )__  _( )__  _( )__  _( )__  _( )__  _( )__  _( )__ 
# _|     _||     _||     _||     _||     _||     _||     _|
#(_ P _ ((_ H _ ((_ P _ ((_ - _ ((_ F _ ((_ P _ ((_ M _ (_ 
#  |_( )__||_( )__||_( )__||_( )__||_( )__||_( )__||_( )__|

#Do apt-get update
bash "Run apt-get update" do
    code "apt-get update"
    action :run
end

#Install Prereqs, PHP, PHP-FPM and Other Modules
case node[:platform]
when "ubuntu", "debian"

    #Install PHP-FPM Package
    node[:packages][:ubuntu_debian][:fpm].each do |install_packages|
        package install_packages do
            action :install
        end
    end
    
    #Install PHP Modules if Enabled
    node[:packages][:ubuntu_debian][:php_modules].each do |install_packages|
        package install_packages do
            action :install
            only_if { node[:packages][:ubuntu_debian][:install_php_modules] }
        end
    end

    #Enable and Restart PHP5-FPM
    service node[:packages][:ubuntu_debian][:fpm] do
        supports :start => true, :stop => true, :restart => true, :reload => true
        action [ :enable, :restart ]
    end

end