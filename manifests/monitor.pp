# monitor.pp

class puppetmonitor{

 package { ['vim', 'curl', 'git']:
  ensure => installed,
 }

 user { 'monitor':
  ensure     => present,
  home       => '/home/monitor',
  managehome => true,
  shell      => '/bin/bash',
 }

 file { '/home/monitor/scripts':
   ensure => directory,
   owner => 'monitor',
   group => 'monitor',
   mode  => '0755',
 }
 exec { 'download_memory_check':
   command => '/usr/bin/curl -o /home/monitor/scripts/memory_check https://raw.githubusercontent/ghuellll/part2/master/memory_check',
   creates => '/home/monitor/scripts/memory_check',
   user    => 'monitor',
   group   => 'monitor',
   require =>  File['/home/monitor/scripts'],
 } 
  
 file { '/home/monitor/src/my_memory_check':
   ensure => 'link',
   target => '/home/monitor/scripts/memory_check',
   owner  => 'monitor',
   group  => 'monitor',
 }
 
 cron { 'memory_check_cron':
   ensure => 'present',
   command => '/home/monitor/src/my_memory_check',
   user => 'monitor',
   minute => '*/10',
 }
}
   
