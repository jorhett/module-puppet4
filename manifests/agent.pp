#Class: puppet4::agent
#
# Manages the Puppet agent service and configuration
#
##Parameters
#
# @param [String] status Whether Puppet client should run as a daemon
# * `status`  
#   Whether Puppet client should run as a daemon
#    values: running, stopped
#  
# @param [Boolean] enabled Whether Puppet client should start at boot
# * `enabled`   
#  Whether Puppet client should start at boot
#
# @param [Hash] config Hash of configuration settings for the [agent] block of puppet.conf
# * `config`  
# Hash of key/value Puppet configuration settings for the [agent] block of puppet.conf
#  
# @example Hiera Sample
#    classes:
#      = puppet4::agent
#  
#    puppet4::agent::status: 'running'
#    puppet4::agent::enabled: true
#    puppet4::agent::config:
#      server: 'puppet.example.com'
#
##Authors
# @author Jo Rhett https://github.com/jorhett/puppet4-module/issues
# Jo Rhett, Net Consonance  
# report issues at https://github.com/jorhett/puppet4-module/issues
#
##Copyright
# Copyright 2015, Net Consonance
# All Rights Reserved
#
class puppet4::agent(
  # input parameters and default values for the class
  Enum['running','stopped'] $status  = 'running',
  Boolean $enabled                   = true,
  Hash $config                       = {},
) inherits puppet4 {

  # Write each agent configuration option to the puppet.conf file
  $config.each |$setting,$value| {
    ini_setting { "agent $setting":
      ensure  => present,
      path    => '/etc/puppetlabs/puppet/puppet.conf',
      section => 'agent',
      setting => $setting,
      value   => $value,
      require => Package['puppet-agent'],
      notify  => Exec['configuration-has-changed'],
    }
  }

  # Manage the Puppet agent service
  service { 'puppet':
    ensure    => $status,
    enable    => $enabled,
    subscribe => [Package['puppet-agent'],Exec['configuration-has-changed']],
  }
}
