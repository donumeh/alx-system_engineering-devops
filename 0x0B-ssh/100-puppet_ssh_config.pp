# Using a puppet to make changes to the config file

file {'/home/ubuntu/.ssh':
  ensure => directory,
  owner  => 'ubuntu',
  group  => 'ubuntu',
  mode   => '0700',
}

file {'/home/ubuntu/.ssh/config':
  ensure  => present,
  owner   => 'ubuntu',
  group   => 'ubuntu',
  mode    => '0600',
  content => '',
}

file_line { 'Add Host block':
  path  => '/home/ubuntu/.ssh/config',
  line  => 'Host myserver',
  match => '^Host myserver',
}

file line {'Add HostName':
  path  => '/home/ubuntu/.ssh/config',
  line  => '    User ubuntu',
  match => '^\s*User\s+',
  after => '^Host myserver',
}

first_line {'Add IdentityFile':
  path  => '/home/ubuntu/.ssh/config',
  line  => '    IdentityFile /home/ubuntu/.ssh/school',
  match => '^\s*IdentityFile\s+',
  after => '^Host myserver',
}

file_line {'Turn off passwd auth':
  path  => '/home/ubuntu/.ssh/config',
  line  => '    PasswordAuthentication no',
  match => '^\s*PasswordAuthentication\s+',
  after => '^Host myserver',
}
