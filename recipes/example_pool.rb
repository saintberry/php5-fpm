#
# Cookbook Name:: php5-fpm
# Recipe:: example_pool
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

php5_fpm_pool "test" do
	listen_address "127.0.0.1"
	listen_port 8080
	overwrite true
	action :create
	notifies :restart, "service[#{node[:php_fpm][:package]}]", :delayed
end

php5_fpm_pool "test" do
	pool_user "fpm_user"
	pool_group "fpm_group"
	overwrite true
	action :modify
	notifies :restart, "service[#{node[:php_fpm][:package]}]", :delayed
end