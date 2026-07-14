class configr_wordpress::install {

  package { [
    'nginx',
    'openlitespeed',
    'lsphp82',
    'unzip',
    'wget'
  ]:
    ensure => installed,
  }

  service { 'nginx':
    ensure => running,
    enable => true,
  }

  service { 'lsws':
    ensure => running,
    enable => true,
  }

}