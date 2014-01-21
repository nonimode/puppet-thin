What is it?
===========

A puppet module that configures ruby thin, sets up site configurations, and
an init script for managing services.

it is based on the [thin module by evenup](https://github.com/evenup/evenup-thin)

Usage:
------

Generic thin install
<pre>
  class { 'thin': }
</pre>

By default the "/usr/bin/thin" executable is used, if you want to specify a different bin:
<pre>
  class { 'thin': 
    exec => '/path/to/bin/thin'
  }
</pre>

Adding a thin site
<pre>
  thin::site { 'coolapp':
    chdir       => '/usr/share/coolapp',
    log         => '/var/log/coolapp/coolapp.log',
    port        => 3200,
    user        => 'coolapp',
    group       => 'coolapp',
    servers     => 1,
    environment => 'production';
  }
</pre>
