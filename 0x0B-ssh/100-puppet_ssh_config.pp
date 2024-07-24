# check if the puppet is installed

package {'puppet':
  ensure => present,
}


# ensure the puppet stdlib is installed

exec {'puppet_stdlib':
  command => '/usr/bin/puppet module install puppetlabs-stdlib',
  require => Package['puppet'],
}

# ensure the puppet inifile is installed

exec {'puppet_inifile':
  command => '/usr/bin/puppet module install puppetlabs-inifile',
  require => Exec['puppet_stdlib'],
}

# ensure the file exists

file {'/etc/ssh/ssh_config':
  ensure  => present,
  require => Exec['puppet_inifile'],
}

# append the host

file_line {'insert_host':
  ensure  => present,
  path    => '/etc/ssh/ssh_config',
  line    => "Host ubuntu_server",
  match   => "^Host ubuntu_server",
  require  => File['/etc/ssh/ssh_config'],
}

# append the HostName

file_line {'insert_hostname':
  ensure  => present,
  path    => '/etc/ssh/ssh_config',
  after   => 'Host ubuntu_server',
  line    => '    HostName 98.98.98.98',
  match   => '^\s+HostName 98.98.98.98',
  require => File['/etc/ssh/ssh_config'],
}

# append the user name

file_line {'inser_user':
  ensure  => present,
  path    => '/etc/ssh/ssh_config',
  after   => '    HostName 98.98.98.98',
  line    => '    User ubuntu',
  match   => '^\s+User ubuntu',
  require => File['/etc/ssh/ssh_config'],
}
