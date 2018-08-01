node 'node4' {
    
  include ::haproxy
  haproxy::listen { 'app':
    collect_exported => false,
    ipaddress        => $::ipaddress,
    ports            => '80',
  }
  haproxy::balancermember { 'node1':
    listening_service => 'app',
    server_names      => 'node1.rns.com',
    ipaddresses       => 'node1',
    ports             => '8080',
    options           => 'check',
  }
  haproxy::balancermember { 'node2':
    listening_service => 'app',
    server_names      => 'node2.rns.com',
    ipaddresses       => 'node2',
    ports             => '8080',
    options           => 'check',
  }
}