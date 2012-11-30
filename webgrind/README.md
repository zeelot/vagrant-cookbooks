Description
===========

Installs and configures webgrind via git as an apache2 site.

Requirements
============

## Platforms:

Tested on:

* Ubuntu 12.04 with apache2

## Cookbooks:

* xdebug
* git
* apache2

Attributes
==========

The installation path can be configured.

* default['webgrind']['install_path'] = "/var/www/webgrind"

By default an apache2 site for webgrind will be set up. 
You can prevent chef from doing this by setting ['webgrind']['webserver'] to false.

* default['webgrind']['webserver'] = 'apache2'

The following are node attributes passed to the configuration template for webgrind.
See the config file for descriptions.

* default['webgrind']['check_version'] = "false"
* default['webgrind']['hide_webgrind_profiles'] = "true"
* default['webgrind']['storage_dir'] = ""
* default['webgrind']['profiler_dir'] = "/tmp"
* default['webgrind']['preprocessed_suffix'] = ".webgrind"
* default['webgrind']['default_timezone'] = "UTC"
* default['webgrind']['date_format'] = "Y-m-d H:i:s"
* default['webgrind']['default_costformat'] = "percent"
* default['webgrind']['default_function_percentage'] = "90"
* default['webgrind']['default_hideInternal_functions'] = "false"
* default['webgrind']['python_executable'] = "/usr/bin/python"
* default['webgrind']['dot_executable'] = "/usr/local/bin/dot"
* default['webgrind']['file_url_format'] = "index.php?op=fileviewer&file=%1$s#line%2$d"
* default['webgrind']['trace_file_list_format'] = "%i (%f) [%s]"

Usage
=====

Simply include the webgrind recipe.

License and Author
==================

Author:: Patrick Connolly (<patrick@myplanetdigital.com>)
Author:: Anusch Athari (<anusch@athari.de>)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
