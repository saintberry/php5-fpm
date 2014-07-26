php5-fpm Cookbook
================
This PHP5-FPM Cookbook allows for installation of PHP-FPM, configuration of users and directories, base configuration, and pool configuration.  The attributes file gives full control over the configration for all pools and PHP-FPM configuration with JSON.

Adding pools can be done by modifying the JSON directly in the attributes file or overriding the attributes through other methods, environments, roles, etc.



Supported Platforms
------------
Debian, Ubuntu
CentOS, RedHat

No additional packages are required.



Changelog
_________

0.1.0
-----
- stajkowski - Intial Commit/Base Recipes.

0.1.3
-----
- stajkowski - Rework attribute structure, prepare for additional platforms.

- - -

0.2.0
-----
- stajkowski - Added Redhat and CentOS support.  Allow for the option to update package repos on the system.

- - -



Attributes
----------

#### php5-fpm::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>["php_fpm"]["install_php_modules"]</tt></td>
    <td>Boolean</td>
    <td>Install Additional PHP Modules</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>["php_fpm"]["update_system"]</tt></td>
    <td>Boolean</td>
    <td>Update repository information</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>["php_fpm"]["users"]</tt></td>
    <td>JSON</td>
    <td>Users/Directories to Add</td>
    <td><tt>Attributes File</tt></td>
  </tr>
  <tr>
    <td><tt>["php_fpm"]["config"]</tt></td>
    <td>JSON</td>
    <td>PHP-FPM.conf Configuration Values/td>
    <td><tt>Attributes File</tt></td>
  </tr>
  <tr>
    <td><tt>["php_fpm"]["pools"]</tt></td>
    <td>JSON</td>
    <td><pool>.conf Configuration Values/td>
    <td><tt>Attributes File</tt></td>
  </tr>
</table>



Usage
-----
#### php-fpm::install

Install PHP5-FPM. Include `php5-fpm::install` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[php5-fpm::install]"
  ]
}
```

#### php5-fpm::create_user

This will create users and directories for use with pools. Include `php5-fpm::create_user` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[php5-fpm::create_user]"
  ]
}
```

#### php5-fpm::configure_pools

This will create pools based on JSON configuration. Include `php5-fpm::configure_pools` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[php5-fpm::configure_pools]"
  ]
}
```

#### php5-fpm::configure_fpm

This will replace the php-fpm.conf file based on JSON configuration. Include `php5-fpm::configure_fpm` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[php5-fpm::configure_fpm]"
  ]
}
```



License and Authors
-------------------
Authors: Brian Stajkowski
