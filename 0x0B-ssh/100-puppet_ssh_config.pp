# Configuring a ssh

package {'ssh':
  ensure => 'present',
  before => File['/etc/ssh/ssh_config.d/new_server.conf'],
}


file {'/etc/ssh/ssh_config.d/new_server.conf':
  ensure  => 'file',
  content => "Host myserver\n\tHostName 98.98.98.98\n\tUser ubuntu\n\tIdentityFile ~/.ssh/school\n\tPasswordAuthentication no\n",
}
