class tomcat::config inherits tomcat {

    file {$::tomcat::config_path :
    
        content  => template('tomcat/tomcat.conf.erb'),
        owner   =>  $::tomcat::user,
        group   =>  $::tomcat::group,
        mode    =>  '0644',
        notify  =>  Service['tomcat'],
    }
}