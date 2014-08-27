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

#Configure REPO for Debian 6.x
if node[:platform].include?("debian") && node[:platform_version].include?("6.")

    #Install nginx repo, platform is set inside template
    cookbook_file "/etc/apt/sources.list.d/dotdeb.list" do
        source "dotdeb.list"
        path "/etc/apt/sources.list.d/dotdeb.list"
        action :create
    end

end

#Check if we are updating the Repos and System
if node[:php_fpm][:update_system]

    #Select Platform
    case node[:platform]
    when "ubuntu", "debian"

        #Do apt-get update
        bash "Run apt-get update" do
            code "apt-get update"
            action :run
        end

        #Check if we are upgrading the system as well
        if node[:php_fpm][:upgrade_system]

            #Do apt-get upgrade
            bash "Run apt-get upgrade" do
                code "DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y"
                action :run
            end

        end

    when "centos", "redhat", "fedora"

        #Do yum check-update
        bash "Run yum check-update" do
            code "yum check-update"
            returns [0, 100]
            action :run
        end

        #Check if we are upgrading the system as well
        if node[:php_fpm][:upgrade_system]

            #Do yum update -y
            bash "Run yum update" do
                code "yum update -y"
                action :run
            end

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
    #Bug in 14.04 for service provider. Adding until resolved.
    if (platform?('ubuntu') && node['platform_version'].to_f >= 14.04)
        provider Chef::Provider::Service::Upstart
    end
    supports :start => true, :stop => true, :restart => true, :reload => true
    action [ :enable, :restart ]
end