php-fpm Cookbook
================
This PHP-FPM Cookbook allows for installation of PHP-FPM, configuration of users and directories, base configuration, and pool configuration.  The attributes file gives full control over the configration for all pools and PHP-FPM configuration with JSON.

Requirements
------------
Ubuntu 12.04+
Debian Wheezy+

No additional packages are required.

Attributes
----------

#### php-fpm::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>["packages"]["ubuntu_debian"]["install_php_modules"]</tt></td>
    <td>Boolean</td>
    <td>Install Additional PHP Modules</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>["users"]["php"]</tt></td>
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

Install PHP-FPM. Include `php-fpm::install` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[php-fpm::install]"
  ]
}
```

#### php-fpm::create_user

This will create users and directories for use with pools. Include `php-fpm::create_user` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[php-fpm::create_user]"
  ]
}
```

#### php-fpm::configure_pools

This will create pools based on JSON configuration. Include `php-fpm::configure_pools` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[php-fpm::configure_pools]"
  ]
}
```

#### php-fpm::configure_fpm

This will replace the php-fpm.conf file based on JSON configuration. Include `php-fpm::configure_fpm` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[php-fpm::configure_fpm]"
  ]
}
```

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Brian Stajkowski
