class tomcat::params {
     
        $color = 'white' 
        $car   = 'figo'
        $user  = 'tomcat'
	    $group = 'tomcat'
		$config_path  = '/etc/tomcat/tomcat.conf'
		$packages  = [ 'tomcat', 'tomcat-webapps' ]
		$service_name = 'tomcat'
		$service_state = running
        $java_home  = '/usr/lib/jvm/jre'
        $shutdown_time  = '30'
        $xms    =   '126M'
        $xmx    =   '256M'
        $deploy_path = '/var/lib/tomcat/webapps'
}
