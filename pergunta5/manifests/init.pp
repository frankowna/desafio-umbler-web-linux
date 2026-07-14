class configr_wordpress (

  String $domain,
  String $user,

) {

  contain configr_wordpress::install

  contain configr_wordpress::config

  contain configr_wordpress::wordpress

}