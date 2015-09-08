# puppet

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with puppet](#setup)
    * [What puppet affects](#what-puppet-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with puppet](#beginning-with-puppet)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This is a module written to manage Puppet 4 configuration, agent, master, and Puppet Server.

## Module Description

Installs and configures Puppet 4, and optionally, the agent, master, and Puppet Server
daemons.

This a demonstration module utilizing Puppet 4 features and demonstrating Puppet best practices.

## Setup

### What puppet affects

* Packages
  * Puppet Package Collection repository
  * Puppet 4 Package
  * Puppet Server Package (optional)
* Configuration Files
  * /etc/puppetlabs/puppet/puppet.conf
  * /etc/puppetlabs/server/webapp.conf

### Setup Requirements

Requires the Puppet 4 package to be installed. (catch-22 yes I know)
I may attempt in the future to test a way to upgrade from Puppet 3 but that is
has not been tested.

### Beginning with puppet

Hiera configuration:

    classes:
      - puppet
      - puppet::agent (optional)

## Usage

Configuration values in Hiera (or supplied by an node terminus):

* Common
  * `puppet::pc_version` = Integer version of the Package Collection to use
  * `puppet::version` = 'latest', 'present', 'absent', or a specific version.
  * `puppet::config` = Hash of configuration parameters for the [main] section of puppet.conf
  * `puppet::user::config` = Hash of configuration parameters for the [user] section of puppet.conf
* Agent
  * `puppet::agent::status` = 'Running' (default) or 'Stopped'
  * `puppet::agent::enabled` = true (default) or false
  * `puppet::agent::config` = Hash of configuration parameters for the [agent] section of puppet.conf
* Server
  * `puppet::server::status` = 'Running' (default) or 'Stopped'
  * `puppet::server::enabled` = true (default) or false
  * `puppet::server::config` = Hash of configuration parameters for the [master] section of puppet.conf
* Master
  * `puppet::master::config` = Hash of configuration parameters for the [master] section of puppet.conf

## Reference

### Setup Requirements

* Classes
  * puppet - Maintains package repository, puppet package, and [main] block of puppet.conf
  * puppet::user - Maintains [user] block of puppet.conf
  * puppet::agent - Maintains [agent] block of puppet.conf and the `puppet` service
  * puppet::master - Maintains [master] block of puppet.conf and the `puppet-master` service
  * puppet::server - Maintains [master] block of puppet.conf and the `puppetserver` service

## Limitations

Uses all features of Puppet 4 therefore only Puppet 4 is supported. May possibly work
with Puppet 3.7 or higher with the 'future' parser but is not tested as such.

## Development

I'll accept any good ideas to improve this module which can be leveraged by everyone.
