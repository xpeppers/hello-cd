Exec { path => ['/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/'] }

file { 'ondrej-list':
  path    => '/etc/apt/sources.list.d/php5.sources.list',
  content => 'deb http://ppa.launchpad.net/ondrej/php5-oldstable/ubuntu lucid main',
  owner   => root,
  group   => root,
  mode    => 0644
}

exec { 'ondrej-apt-key':
  command => 'sudo apt-key adv --keyserver keyserver.ubuntu.com --recv E5267A6C',
  require => File['ondrej-list']
}

$packages = [
  'build-essential',
  'vim',
  'curl',
  'git-core',
  'php5',
  'php5-cli',
  'php5-dev',
  'php5-curl',
  'php5-xdebug',
  'php-apc',
  'php-pear'
]

exec { 'init-apt':
  command => 'apt-get update',
  require => Exec['ondrej-apt-key']
} ->
package { $packages:
  ensure => 'installed'
}

exec { 'install-heroku-toolbelt':
  command => 'wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh',
  unless => 'which heroku',
  logoutput => 'true'
}

exec { 'install-composer':
  command => 'curl -sS https://getcomposer.org/installer | php; \
              mv composer.phar /usr/local/bin/composer',
  unless => 'which composer',
  logoutput => 'true',
  require => Package['curl']
}

file { 'path':
  path    => '/home/vagrant/.bash_profile',
  content => 'export PATH=$PATH::/vagrant/vendor/bin;cd /vagrant',
  owner   => vagrant,
  group   => vagrant,
  mode    => 0644
}
