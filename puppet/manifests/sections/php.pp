$php_version = '5.5.33+dfsg-1+deb.sury.org~precise+1'

include php
include apt

apt::source { 'php55':
  location    => 'http://ppa.launchpad.net/ondrej/php5/ubuntu',
  release     => 'precise',
  repos       => 'main',
  key         => '14AA40EC0831756756D7F66C4F4EA0AAE5267A6C',
  key_server  => 'hkp://keyserver.ubuntu.com:80',
  include_src => true
}

class {
  'php::cli':
    ensure  => $php_version,
    require => Apt::Source['php55'];
  'php::composer':;
  'php::dev':
    ensure  => $php_version,
    require => Apt::Source['php55'];
  'php::fpm':;
  'php::pear':;

  # Extensions
  'php::extension::apc':
    ensure => absent;
  'php::extension::curl':;
  'php::extension::gd':;
  'php::extension::imagick':;
  'php::extension::mcrypt':;
  'php::extension::memcache':;
  'php::extension::mysql':;
}

php::fpm::conf { 'www': user => 'vagrant' }

file { '/etc/php5/conf.d/apc.ini': ensure => absent }
