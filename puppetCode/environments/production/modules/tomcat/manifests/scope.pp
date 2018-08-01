class tomcat::scope inherits tomcat{
    
    notify{"print the scope": 
         message => "
         
           Min Memory Size :  ${xms}
           Max Memory Size   :  ${xmx}
        
        "
    }

}