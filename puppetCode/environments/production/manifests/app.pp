$color = "blue"
$car = "swift"   

node 'node1' {
    
    class{'tomcat':
      
      
      service_state =>  'running'
    }
    
    tomcat::deploy { "sysfoo":

        deploy_url  => 'http://ec2-54-146-101-99.compute-1.amazonaws.com:8081/nexus/content/repositories/releases/com/sod/sysfoo/0.0.1/sysfoo-0.0.1.war',
    }
}

node 'node2' {
    
    notify { 'checkpoint_1':
	    		message => '
		        		Node Definition for Node 1 and Node 2
	    		'
	}
	$color = "green"
    #include tomcat
    #include base
    class {'tomcat':
    
        xms     =>  '100M',
        xmx     =>  '200M',
        service_state   => 'running'
    }
    tomcat::deploy { "sysfoo":

        deploy_url  => 'http://ec2-54-146-101-99.compute-1.amazonaws.com:8081/nexus/content/repositories/releases/com/sod/sysfoo/0.0.1/sysfoo-0.0.1.war',
        checksum_value => '7b2c46ab6f5af93ea6416e369194d68d',
    }
}