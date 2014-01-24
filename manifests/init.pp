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
class thin {
  file { '/var/log/thin':
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => '0775',
  }
}
