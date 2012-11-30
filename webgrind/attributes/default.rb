default['webgrind']['install_path'] = "/var/www/webgrind"

default['webgrind']['webserver'] = 'apache2'

default['webgrind']['check_version'] = "false"
default['webgrind']['hide_webgrind_profiles'] = "true"
default['webgrind']['storage_dir'] = ""
default['webgrind']['profiler_dir'] = "/tmp"
default['webgrind']['preprocessed_suffix'] = ".webgrind"
default['webgrind']['default_timezone'] = "UTC"
default['webgrind']['date_format'] = "Y-m-d H:i:s"
default['webgrind']['default_costformat'] = "percent"
default['webgrind']['default_function_percentage'] = "90"
default['webgrind']['default_hideInternal_functions'] = "false"
default['webgrind']['python_executable'] = "/usr/bin/python"
default['webgrind']['dot_executable'] = "/usr/bin/dot"
default['webgrind']['file_url_format'] = "index.php?op=fileviewer&file=%1$s#line%2$d"
default['webgrind']['trace_file_list_format'] = "%i (%f) [%s]"