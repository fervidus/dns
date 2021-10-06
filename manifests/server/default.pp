# == Class: dns::server::default
#
class dns::server::default (

  Stdlib::Absolutepath $default_file = $dns::server::params::default_file,
  $default_template = $dns::server::params::default_template,

  Optional[Enum['yes','no']] $resolvconf                     = undef,
  $options                                                   = undef,
  Optional[Stdlib::Absolutepath] $rootdir                    = undef,
  Optional[Pattern[/^(yes|no|\s*)$/]] $enable_zone_write     = undef,
  Optional[Pattern[/^(yes|no|1|0|\s*)$/]] $enable_sdb        = undef,
  $disable_named_dbus                                        = undef,
  Optional[Stdlib::Absolutepath] $keytab_file                = undef,
  Optional[Pattern[/^(yes|no|\s*)$/]] $disable_zone_checking = undef,

) inherits dns::server::params {
  file { $default_file:
    ensure  => present,
    owner   => $dns::server::params::owner,
    group   => $dns::server::params::group,
    mode    => '0644',
    content => template("${module_name}/${default_template}"),
    notify  => Class['dns::server::service'],
    require => Package[$dns::server::params::necessary_packages]
  }

}
