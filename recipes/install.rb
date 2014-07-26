#
# Cookbook Name:: php5-fpm
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

if node[:php_fpm][:update_system]

    #Select Platform
    case node[:platform]
    when "ubuntu", "debian"

        #Do apt-get update
        bash "Run apt-get update" do
            code "apt-get update"
            action :run
        end

    when "centos", "redhat"

        #Do yum update -y
        bash "Run yum update" do
            code "yum update -y"
            action :run
        end

    end

end

#Install PHP-FPM Package
package node[:php_fpm][:package] do
    action :install
end
    
#Install PHP Modules if Enabled
node[:php_fpm][:php_modules].each do |install_packages|
    package install_packages do
        action :install
        only_if { node[:php_fpm][:install_php_modules] }
    end
end

#Enable and Restart PHP5-FPM
service node[:php_fpm][:package] do
    supports :start => true, :stop => true, :restart => true, :reload => true
    action [ :enable, :restart ]
end