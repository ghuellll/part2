# monitor.pp

class puppetmonitor{

package { ['vim', 'curl', 'git']:
  ensure =>installed,
}

user { 'monitor':
  ensure     => present,
  home       => '/home/monitor',
  managehome => true,
  shell      => '/bin/bash',
 }
}
