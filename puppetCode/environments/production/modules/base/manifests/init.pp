
class base inherits base::params{

    user{'deploy':
    uid         => '5001',
    password    => '$1$Tmdyi8hc$CTsnCpkd/MzVN.6GTnCf9/',
    home        => '/home/deploy',
    ensure      => 'present',
}

user{'deploy2':
    uid         => '5002',
    password    => '$1$Tmdyi8hc$CTsnCpkd/MzVN.6GTnCf9/',
    home        => '/home/deploy2',
    ensure      => 'present',
}

package { ['wget','tree','git','ntp','unzip']:

    ensure      => 'present',
}

service {$::base::ntp_service:

    ensure      => 'running',
    enable      => 'true'
}

file { '/etc/motd': 
      ensure   => file, 
      owner    => 'root',
      content  => "
      
         This server is a property of XYZ Inc.
         
         SYSTEM INFO 
         ============
         
         Hostname     : ${::fqdn}
         IP Address   : ${::ipaddress}
         Memory       : ${::memory['system']['total']}
         Cores        : ${::processors['count']}
         OS           : ${::os['distro']['description']}      
      "
    }

}
