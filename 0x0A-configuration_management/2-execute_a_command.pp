# execute a command with puppet

exec {'kill_killmenow_process':
  command => '/usr/bin/pkill killmenow',
  path    => ['/usr/bin', '/bin'],
  onlyif  => 'pgrep killmenow',
}
