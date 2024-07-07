# Using a puppet to make changes to the config file

file {'/etc/ssh/ssh_config':
  ensure => present,
  owner  => 'root',
  group  => 'root',
  mode   => '0644',
}

file_line { 'Add Host block':
  path  => '/etc/ssh/ssh_config',
  line  => 'Host myserver',
  match => '^Host myserver',
}

file_line {'Add HostName':
  path  => '/etc/ssh/ssh_config',
  line  => '    HostName 98.98.98.98',
  match => '^\s*HostName\s+',
  after => '^Host myserver',
}

file_line {'Add User':
  path  => '/etc/ssh/ssh_config',
  line  => '    User ubuntu',
  match => '^\s*User\s+',
  after => '^Host myserver',
}

first_line {'Add IdentityFile':
  path  => '/etc/ssh/ssh_config',
  line  => '    IdentityFile ~/.ssh/school',
  match => '^\s*IdentityFile\s+',
  after => '^Host myserver',
}

file_line {'Turn off passwd auth':
  path  => '/etc/ssh/ssh_config',
  line  => '    PasswordAuthentication no',
  match => '^\s*PasswordAuthentication\s+',
  after => '^Host myserver',
}
