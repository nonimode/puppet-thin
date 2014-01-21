# == Define: thin::site
#
# This class sets up a thin site config
#
#
# === Parameters
#
# [*chdir*]
#   String.  Base directory application is installed in
#
# [*address*]
#   String.  IP address to listen on
#   Default: 0.0.0.0
#
# [*daemonize*]
#   Boolean.  Should the process be forked to a daemon
#   Default: true
#
# [*environment*]
#   String.  Environment mode the site is running in
#   Default: production
#
# [*log*]
#   String.  Full path to the logfile
#   Default: /var/log/${name}/{$name}.log
#
# [*group*]
#   String.  What group should the service be run as?
#   Default: thin
#
# [*max_conns*]
#   Integer.  The maximum number of concurrent connections.
#   Default: 1024
#
# [*max_persistent_conns*]
#   Integer.  Maximum number of persistent connections
#   Default: 512
#
# [*pid*]
#   String.  Full path to the pidfile
#   Default: /var/log/subsys/${name}
#
# [*port*]
#   Integer.  What port is the first service listening on
#   Default: 3000
#
# [*servers*]
#   Integer.  How many thin servers to start.  Ports are sequential from $port
#   Default: 3
#
# [*timeout*]
#   Integer.  Timeout in seconds
#   Default: 15
#
# [*user*]
#   String.  User to run the service as
#   Default: thin
#
# [*tag*]
#   String. Tag to identify the thin process
#   default: ${name}
#
# === Examples
#
# thin::site { 'coolapp':
#    chdir       => '/usr/share/coolapp',
#    log         => '/var/log/coolapp/coolapp.log',
#    port        => 3200,
#    user        => 'coolapp',
#    group       => 'coolapp',
#    servers     => 1,
#    environment => 'production';
# }
#
# === Authors
# * Leo Bossmann <mailto:leo@noni-mode.de>
#
#
# Based on the 'evenup-thin' puppet module by Justin Lambert <mailto:jlambert@letsevenup.com>
#
define thin::site (
  $chdir,
  $address              = '0.0.0.0',
  $daemonize            = true,
  $environment          = 'production',
  $log                  = "/var/log/${name}/${name}.log",
  $group                = 'thin',
  $max_conns            = '1024',
  $max_persistent_conns = '512',
  $pid                  = "/var/lock/subsys/${name}",
  $port                 = '3000',
  $servers              = '3',
  $timeout              = '15',
  $user                 = 'thin',
  $tag                  = "${name}"
){

  include thin

  $logdir = inline_template('<%= File.dirname(scope.lookupvar(\'log\') ) %>')

  file {
    "/etc/thin/${name}.yml":
      owner   => root,
      group   => root,
      content => template('thin/thin.yml'),
      notify  => Service["thin"];

    $logdir:
      ensure => directory,
      owner  => $user,
      group  => $group,
      mode   => '0775';
  }
}
