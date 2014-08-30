php5-fpm Cookbook
================
This PHP5-FPM Cookbook allows for installation of PHP-FPM, configuration of users and directories, base configuration, and pool configuration.  The attributes file gives full control over the configration for all pools and PHP-FPM configuration with JSON.

Adding pools can be done by modifying the JSON directly in the attributes file or overriding the attributes through other methods, environments, roles, etc.

If you do not wish to use a configuration value, you can simply set it to NOT_SET and it will not be included in the confiruation file.  Additionally, you can add more configuration values if they are missing, future proofing the template generation.

Supported Platforms
------------
Debian(6.x+), Ubuntu(10.04+)
CentOS(6.x+), RedHat, Fedora(20+)

No additional packages are required.

Tested Against:

Debian 6.x and above
Ubuntu 10.04 and above
CenOS 6.x and above
Fedora 20

Planned Improvements
---------

0.2.3 - Add environment variables. Add additional OS support.
0.3.0 - Develop LWRP for Pool Add/Modify/Remove

Changelog
---------

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

0.2.1
-----
- stajkowski - Tested Fedora 20 support.  Generated Test Kitchen files and preparing for kitchen scripts.

- - -

0.2.2
-----
- stajkowski - Updated install receipe to fix the update/upgrade operation.  Now allows for the option and fully functional. Added and tested against more platforms, check .kitchen.yml.  Fixed 14.04 bug for service provider, will include this until the bug is fixed.  Added support for Debian 6.x and above and added support for Ubuntu 10.04 and above, this has a seperate JSON configuration due to recent configuration settings not supported in these earlier versions.

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
    <td><tt>["php_fpm"]["upgrade_system"]</tt></td>
    <td>Boolean</td>
    <td>Perform upgrades to OS</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>["php_fpm"]["create_users"]</tt></td>
    <td>Boolean</td>
    <td>Configure Users</td>
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
    <td>PHP-FPM.conf Configuration Values</td>
    <td><tt>Attributes File</tt></td>
  </tr>
  <tr>
    <td><tt>["php_fpm"]["pools"]</tt></td>
    <td>JSON</td>
    <td>pool.conf Configuration Values</td>
    <td><tt>Attributes File</tt></td>
  </tr>
  <tr>
    <td><tt>["php_fpm"]["ubuntu1004_config"]</tt></td>
    <td>JSON</td>
    <td>PHP-FPM.conf Configuration Values Ubuntu 10.04 Only</td>
    <td><tt>Attributes File</tt></td>
  </tr>
  <tr>
    <td><tt>["php_fpm"]["ubuntu1004_pools"]</tt></td>
    <td>JSON</td>
    <td>pool.conf Configuration Values Ubuntu 10.04 Only</td>
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
