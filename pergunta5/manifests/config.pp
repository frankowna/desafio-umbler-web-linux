class configr_wordpress::config (

  String $user = 'cliente',
  String $group = 'cliente',
  String $domain = 'exemplo.com',
  String $docroot = "/home/${user}/public_html",

) {

  group { $group:
    ensure => present,
  }

  user { $user:
    ensure     => present,
    gid        => $group,
    home       => "/home/${user}",
    managehome => true,
    shell      => '/bin/bash',
  }

  file { $docroot:
    ensure  => directory,
    owner   => $user,
    group   => $group,
    mode    => '0755',
    recurse => true,
  }

  file { "/etc/nginx/sites-available/${domain}.conf":
    ensure  => file,
    content => template('configr_wordpress/nginx_vhost.erb'),
    notify  => Service['nginx'],
  }

}