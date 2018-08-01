node 'node3' {
    
    notify { 'checkpoint_1':
	    		message => '
		        		Node Definition for Node 3 
	    		'
	}
	
    class {'tomcat':
    
        xms     =>  '100M',
        xmx     =>  '200M',
        service_state   => 'running'
    }
    tomcat::deploy { "sysfoo":

        deploy_url  => 'http://ec2-54-146-101-99.compute-1.amazonaws.com:8081/nexus/content/repositories/releases/com/sod/sysfoo/0.0.1/sysfoo-0.0.1.war',
        
    }
}