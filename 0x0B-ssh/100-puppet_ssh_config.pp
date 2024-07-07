# Ensure the puppetlabs-concat module is available
exec { 'install-concat':
  command => '/opt/puppetlabs/bin/puppet module install puppetlabs-concat',
  path    => ['/bin', '/usr/bin'],
  unless  => '/opt/puppetlabs/bin/puppet module list | grep puppetlabs-concat',
}

# Define the target file
concat { '/etc/ssh/ssh_config':
  owner => 'root',
  group => 'root',
  mode  => '0644',
}

# Add Host block
concat::fragment { 'Host block':
  target  => '/etc/ssh/ssh_config',
  content => "Host myserver\n",
  order   => 10,
}

# Add HostName
concat::fragment { 'HostName':
  target  => '/etc/ssh/ssh_config',
  content => "    HostName 98.98.98.98\n",  # Replace with your server's IP address or hostname
  order   => 20,
}

# Add User
concat::fragment { 'User':
  target  => '/etc/ssh/ssh_config',
  content => "    User ubuntu\n",
  order   => 30,
}

# Add IdentityFile
concat::fragment { 'IdentityFile':
  target  => '/etc/ssh/ssh_config',
  content => "    IdentityFile ~/.ssh/school\n",
  order   => 40,
}

# Add PasswordAuthentication
concat::fragment { 'PasswordAuthentication':
  target  => '/etc/ssh/ssh_config',
  content => "    PasswordAuthentication no\n",
  order   => 50,
}

