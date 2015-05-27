# ###Class: puppet4
#
# Full description of class puppet4 here.
#
# ###Parameters
#
# Document parameters here.
# @param collection_version Which Package Collection repository to use?
#  Integer values: 1 (default), ...
#
# @param repo_enabled Whether to enable the repo
#  Boolean values: true (default), false
#  Only useful for systems with the Yum package manager
#
# @param loglevel Default loglevel
#  values: debug, info (default), notice, warning, err, alert, emerg, crit, verbose
#
# ###Variables
#
# Here you should define a list of variables outside this module it uses.
#
#  None.
#
# ###Examples
#
# @examples Resource style:
#  class { 'puppet4':
#    collection_version => 1,
#    repo_enabled       => true,
#    loglevel           => 'warning',
#  }
#
# @examples Hiera: 
#  classes:
#    - puppet4::client
#    - puppet4::server
#
#  puppet4::collection_version: 1
#  puppet4::repo_enabled      : true
#  puppet4::loglevel          : warning
#
# ###Authors
#
# Jo Rhett https://github.com/jorhett/puppet4-module/issues
#
# manifests/init.pp
class puppet4(
  # common variables for all Puppet4 classes
  Integer $collection_version = 1,
  Boolean $repo_enabled = true,
  String $loglevel = 'warning',
) {
  
  if( $facts['os']['family'] == 'RedHat' ) {
    yumrepo { "puppetlabs-pc${collection_version}":
      ensure   => 'present',
      baseurl  => "http://yum.puppetlabs.com/el/7/PC${collection_version}/\$basearch",
      descr    => "Puppet Labs PC${collection_version} Repository EL ${facts['os']['release']['major']} - \$basearch",
      enabled  => $repo_enabled,
      gpgcheck => '1',
      gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
    }
  }
}
