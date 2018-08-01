class tomcat (

    $xms            = $::tomcat::params::xms, 
    $xmx            = $::tomcat::params::xmx,
    $service_state  = $::tomcat::params::service_state
) inherits tomcat::params{

    include tomcat::scope
   include tomcat::install
   include tomcat::config
   include tomcat::service
}
