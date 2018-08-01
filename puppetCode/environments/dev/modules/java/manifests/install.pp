class java::install {

    package{['epel-release','java-1.7.0-openjdk']:
    
        ensure  => 'installed'
    }
}