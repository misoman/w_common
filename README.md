w_common Cookbook
==================

[![Build Status](https://travis-ci.org/haapp/w_common.svg?branch=master)](https://travis-ci.org/haapp/w_common)

Chef cookbook to instal and configure common packages and configurations among multiple kinds of high availability application stack virtual machines.

Requirements
------------
Cookbook Dependency:
* apt
* git
* monit
* firewall
* ntp
* sudo
* timezone-ii
* hostname

Supported Platform:
Ubuntu 14.04, Ubuntu 12.04

Usage
-----
#### w_haproxy::default

Include `w_common` in your node/role's `run_list` with other haapp cookbook:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[w_haproxy]",
    "recipe[w_apache]"
  ]
}
```

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Install reqired gems
```
bundle install
```
4. Write your change
5. Write tests for your change (if applicable)
6. Run the tests, ensuring they all pass
```
bundle exec rspec
bundle exec kithen test
```
7. Submit a Pull Request using Github

License and Authors
-------------------
Authors:
* Joel Handwell @joelhandwell
* Full Of Lilies @fulloflilies
