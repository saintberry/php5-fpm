
#SET INSTALL MODULES
default["packages"]["ubuntu_debian"]["fpm"] = "php5-fpm"
default["packages"]["ubuntu_debian"]["install_php_modules"] = true
default["packages"]["ubuntu_debian"]["php_modules"] = [ 'php5-common', 
														'php5-mysql', 
														'php5-curl', 
														'php5-gd', 
														'php-pear', 
														'php5-mcrypt', 
														'php5-memcache', 
														'php5-snmp', 
														'php5-sqlite', 
														'php5-tidy', 
														'php5-xmlrpc', 
														'php5-xsl' 
													]

#SET USERNAMES AND FOLDERS
default["users"]["php"] = '{ "users": 
                            		{ "joom_user": { "dir": "/joom_base", "system": "true", "group": "www-data" } } 
                            }'

#SET POOLS AND POOL CONFIGURATION
default["php_fpm"]["ubuntu_debian"]["base_path"] = "/etc/php5/fpm"
default["php_fpm"]["ubuntu_debian"]["pools_path"] = "#{node[:php_fpm][:ubuntu_debian][:base_path]}/pool.d"

default["php_fpm"]["config"] = '{ "config":
									{
									"pid": "/var/run/php5-fpm.pid",
									"error_log": "/var/log/php5-fpm.log",
									"syslog.facility": "daemon",
									"syslog.ident": "php-fpm",
									"log_level": "notice",
									"emergency_restart_threshold": "0",
									"emergency_restart_interval": "0",
									"process_control_timeout": "0",
									"process.max": "0",
									"daemonize": "yes",
									"rlimit_files": "NOT_SET",
									"rlimit_core": "NOT_SET",
									"events.mechanism": "NOT_SET"
									},
								  "pool_directory": "include=/etc/php5/fpm/pool.d/*.conf"
								}'
								
default["php_fpm"]["pools"] = '{ "www":
									{
										"user": "www-data",
										"group": "www-data",
										"listen": "127.0.0.1:9000",
										"pm": "dynamic",
										"pm.max_children": "10",
										"pm.start_servers": "4",
										"pm.min_spare_servers": "2",
										"pm.max_spare_servers": "6",
										"pm.process_idle_timeout": "10s",
										"pm.max_requests": "0",
										"pm.status_path": "/status",
										"ping.path": "/ping",
										"ping.response": "/pong",
										"access.format": "%R - %u %t \"%m %r\" %s",
										"request_slowlog_timeout": "0",
										"request_terminate_timeout": "0",
										"chdir": "/",
										"catch_workers_output": "no",
										"security.limit_extensions": ".php",
										"access.log": "NOT_SET",
										"slowlog": "NOT_SET",
										"rlimit_files": "NOT_SET",
										"rlimit_core": "NOT_SET",
										"chroot": "NOT_SET"
									}
								}'