#action create
action :create do

    #if the file exists and we are not overwritting, alert
    if @current_resource.exists && !@current_resource.overwrite
        Chef::Log.info "#{ @new_resource } already exists - please set to overwrite if you wish to replace this file"
    else
        #otherwise converge the file by creating it
        converge_by("Create #{ @new_resource }") do
            create_file
        end
    
    end

end

#action modify
action :modify do

    #must make sure the file exists
    if @current_resource.exists
        #if so, converge by modifying the file
        converge_by("Modifying #{ @new_resource }") do
            modify_file
        end

    else
        #otherwise alert
        Chef::Log.info "#{ @new_resource } does not exist. Please create first with action :create"
    end

end

#must load current resource state
def load_current_resource
    @current_resource = Chef::Resource::PHP5FPMCreate.new(@new_resource.name)
    #default entries, will override if file exists and can find a matching configuration key
    @current_resource.pool_name(@new_resource.pool_name)
    @current_resource.pool_user(@new_resource.pool_user)
    @current_resource.pool_group(@new_resource.pool_group)
    @current_resource.listen_address(@new_resource.listen_address)
    @current_resource.listen_port(@new_resource.listen_port)

    #if the file exists, load current state
    if file_exists?(@current_resource.pool_name)

        #open the file for read
        ::File.open("#{ node[:php_fpm][:pools_path] }/#{ @current_resource.pool_name }.conf", "r") do |fobj|

            #loop through each line
            fobj.each_line do |fline|

                #if the line contains configuration key, pull value
                if fline.include? "user"
                    Chef::Log.debug "Found matching line #{ fline } - modifying current resource"
                    #split and take second position in arrary
                    lstring = fline.split('=').at(1)
                    #remove newline chars and whitespacing
                    @current_resource.pool_user(lstring.chomp.strip)
                end

                #if the line contains configuration key, pull value
                if fline.include? "group"
                    Chef::Log.debug "Found matching line #{ fline } - modifying current resource"
                    #split and take second position in arrary
                    lstring = fline.split('=').at(1)
                    #remove newline chars and whitespacing
                    @current_resource.pool_group(lstring.chomp.strip)
                end

                #if the line contains configuration key, pull value
                if fline.include? "listen"
                    Chef::Log.debug "Found matching line #{ fline } - modifying current resource"
                    #split and take second position in arrary
                    lstring = fline.split('=').at(1)
                    #split away the address and port
                    sp_address = lstring.split(':').at(0)
                    sp_port = lstring.split(':').at(1)
                    #remove newline chars and whitespacing
                    @current_resource.listen_address(sp_address.chomp.strip)
                    @current_resource.listen_port(sp_port.chomp.strip.to_i)
                end

            end

        end

        #flag that they current file exists
        @current_resource.exists = true
    end

end

#method for creating a pool file
def create_file

    #open the file and put new values in
    Chef::Log.info "Creating file #{ node[:php_fpm][:pools_path] }/#{ @new_resource.pool_name }.conf!"
    ::File.open("#{ node[:php_fpm][:pools_path] }/#{ @new_resource.pool_name }.conf", "w") do |f|
        
        f.puts "[#{ @new_resource.pool_name }]"

        f.puts "#SETTING CONFIGURATION: #{ @new_resource.pool_user } ###############"
        f.puts "user = #{ @new_resource.pool_user }"

        f.puts "#SETTING CONFIGURATION: #{ @new_resource.pool_group } ###############"
        f.puts "group = #{ @new_resource.pool_group }"

        f.puts "#SETTING CONFIGURATION: #{ @new_resource.listen_address }:#{ @new_resource.listen_port } ###############"
        f.puts "listen = #{ @new_resource.listen_address }:#{ @new_resource.listen_port }"

    end

end

#method for modifying a pool file
def modify_file

    file_name = "#{ node[:php_fpm][:pools_path] }/#{ @current_resource.pool_name }.conf"

    #if the values do not match, update with gsub
    if @current_resource.pool_user != @new_resource.pool_user
        find_replace(file_name,@current_resource.pool_user,@new_resource.pool_user)
    end

    #if the values do not match, update with gsub
    if @current_resource.pool_group != @new_resource.pool_group
        find_replace(file_name,@current_resource.pool_group,@new_resource.pool_group)
    end

    #if the values do not match, update with gsub
    if @current_resource.listen_address != @new_resource.listen_address || @current_resource.listen_port != @new_resource.listen_port
        find_replace(file_name,@current_resource.listen_address,@new_resource.listen_address)
        find_replace(file_name,@current_resource.listen_port,@new_resource.listen_port)
    end

end

#method for finding and replacing the configuration values
def find_replace(file_name,find_str,replace_str)
    Chef::Log.debug "Line in #{ file_name } - #{ find_str } does not match desired configuration, updating with #{ replace_str }"
    ::File.write(f = "#{ file_name }", ::File.read(f).gsub("#{ find_str }","#{ replace_str }"))
end

#method for checking if the pool file exists
def file_exists?(name)

    #if file exists return true
    Chef::Log.debug "Checking to see if the curent file: '#{ name }.conf' exists in pool directory #{ node[:php_fpm][:pools_path] }"
    ::File.file?("#{ node[:php_fpm][:pools_path] }/#{ name }.conf")

end