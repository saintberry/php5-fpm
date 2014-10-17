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
	overwrite true
	action :create
	notifies :restart, "service[#{node[:php_fpm][:package]}]", :delayed
end

php5_fpm_pool "test" do
	pool_user "testing_user"
	pool_group "testing_pool"
	listen_address "10.10.10.10"
	listen_port 8080
	overwrite true
	action :modify
	notifies :restart, "service[#{node[:php_fpm][:package]}]", :delayed
end