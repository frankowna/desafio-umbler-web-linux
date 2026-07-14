class configr_wordpress::wordpress (

  String $user = 'cliente',
  String $docroot = "/home/${user}/public_html",

) {

  exec { 'download_wordpress':

    command => "wget https://wordpress.org/latest.tar.gz -O /tmp/latest.tar.gz",

    creates => "/tmp/latest.tar.gz",

  }

  exec { 'extract_wordpress':

    command => "tar -xzf /tmp/latest.tar.gz -C /tmp",

    creates => "/tmp/wordpress",

    require => Exec['download_wordpress'],

  }

  exec { 'copy_wordpress':

    command => "cp -R /tmp/wordpress/* ${docroot}/",

    creates => "${docroot}/wp-config-sample.php",

    require => Exec['extract_wordpress'],

  }

}