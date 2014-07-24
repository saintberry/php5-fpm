#
# Cookbook Name:: php-fpm
# Recipe:: create_user
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

#Parse users
parsed_users = JSON.parse(node[:users][:php])

#Create Folder Strucuture and PHP User
parsed_users["users"].each do |username,config|

    #Create the Users
    user username do
        home parsed_users["users"][username]["dir"]
        shell '/bin/bash'
        system parsed_users["users"][username]["system"] == "true"
    end

    #Create the Directories
    directory parsed_users["users"][username]["dir"] do
        owner username
        group parsed_users["users"][username]["group"]
        mode 0755
        action :create
        recursive true
    end

end