define tomcat::deploy (

     $deploy_path = $::tomcat::deploy_path,
     $deploy_url,
     #$checksum_value,
){

    file {"${deploy_path}/${name}.war":

        source  => "${deploy_url}",
        owner   => $::tomcat::user,
        group   => $::tomcat::group,
        mode    => '0755',
        notify  => Exec["purge_context"]
    }
    
    exec { "purge_context":
        path        => ['/bin', '/usr/bin', '/usr/sbin'],
        command     => "rm -rf ${deploy_path}/${name}",
        refreshonly => true,
        notify      => Service[$::tomcat::service_name],
  }

}