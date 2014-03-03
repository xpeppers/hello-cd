Exec { path => ['/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/'] }

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

class { 'apache':
  mpm_module => 'prefork',
  require => Exec['init-apt']
}

class { ['apache::mod::rewrite', 'apache::mod::php']:
}

apache::vhost { 'hello-cd.local':
  port => '80',
  override => 'All',
  docroot => '/vagrant',
  options => 'Indexes FollowSymLinks MultiViews'
}3

host { 'hello-cd.local':
  ensure => 'present',
  ip => '127.0.0.1'
}

