# Install flask using puppet

package {'python3':
  ensure    => 'installed',
}


package {'python3-pip':
  ensure  => 'installed',
  require => Package['python3'],
}

package {'flask':
  ensure   => '2.1.0',
  provider => 'pip3',
  require  => Package['python3-pip'],
}

package {'werkzeug':
  ensure   => '2.1.1',
  provider => 'pip3',
  require  => Package['flask'],
}
