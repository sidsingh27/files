class tomcat::install{

    include java
    package { $::tomcat::packages:
        
        ensure      => 'installed',
        require     => Package['epel-release'],
    }
}