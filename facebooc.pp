package { ['libsqlite3-dev', 'sqlite3']:}

exec { 'download_facebooc_from_source':
  command  => 'wget https://github.com/jserv/facebooc/archive/master.zip',
  path => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
  cwd      => '/opt',
  user     => 'root',
  creates  => '/opt/master.zip',
  notify   => Exec['extract_facebook_app']
}


exec { 'extract_facebook_app':
  command      => 'unzip master.zip  && touch /opt/.facebooc_compile',
  path => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
  refreshonly  => true,
  cwd          => '/opt',
  user         =>  'root',
  #subscribe    =>  Exec['download_facebooc_from_source']
}

exec { 'compile_facebooc':
  command  => 'make all && rm /opt/.facebooc_compile',
  path => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
  cwd      => '/opt/facebooc-master',
  user     => 'root',
  onlyif   => 'test -f /opt/.facebooc_compile',
}


exec { 'run_facebooc':
  command  => 'bin/facebooc 16000 &',
  path => '/usr/bin:/usr/sbin:/bin:/usr/local/bin:/opt/facebooc-master',
  cwd      => '/opt/facebooc-master',
  user     => 'root',
  unless   => 'netstat -an | grep 16000 | grep -i listen',
}