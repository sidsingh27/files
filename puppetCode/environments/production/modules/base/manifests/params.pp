class base::params {

  case $::os['family'] {
    	'Debian': {
      		$ntp_service = 'ntp'
    	}
    	'RedHat': {
      		$ntp_service = 'ntpd'
    	}
  }
}