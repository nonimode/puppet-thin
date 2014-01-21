# Class: thin
#
# This module configures the thin rubygem. Thin has top be installed already
#
#
# === Examples
#
# * Installation:
#     class { 'thin': }
#
#
# === Authors
# * Leo Bossmann <mailto:leo@noni-mode.de>
#
#
# Based on the 'evenup-thin' puppet module by Justin Lambert <mailto:jlambert@letsevenup.com>
#
class thin ( $exec = '/usr/bin/thin' ) {
  service { 'thin':
    ensure    => running,
    enable    => true,
    hasstatus => true,
    require   => File['/etc/init.d/thin']
  }

  file { '/etc/thin':
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => '0555',
    purge   => true,
    recurse => true,
    force   => true,
  }

  file { '/etc/init.d/thin':
    owner   => root,
    group   => root,
    mode    => '0555',
    content => template('thin/thin.init')
  }
}
