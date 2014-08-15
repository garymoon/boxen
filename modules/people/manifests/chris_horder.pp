class people::chris_horder {
  include tunnelblick
  include keepassx
  include sublime_text
  include tmux
  include evernote 
  include vlc
  # include redis
  include iterm2::stable
  include java
  include vagrant
  include virtualbox
  include eclipse::java
  include cyberduck
  include firefox
  include textmate::textmate2::release
  include netbeans::jee
  include skype
  include chicken_of_the_vnc

  $home     = "/Users/${::boxen_user}"
  $my       = "${home}/my"
  $dotfiles = "${my}/dotfiles"

  
  file { $my:
    ensure  => directory
  }

  package { ['python'] :
    ensure => installed,
  }

  package { ['htop', 'ipcalc', 'aspell', 'lftp', 'tree', 'git-flow', 'gradle', 'pwgen', 'wireshark', 'unrar', 'youtube-dl', 'mtr'] :
    ensure => installed,
  }

  package { 'awscli' :
    ensure    => latest,
    provider  => 'pip',
    require   => 'Package[python]'
  }

  ruby::gem { 'tmuxinator for all rubies':
    gem          => 'tmuxinator',
    version      => '~> 0.1',
    ruby         => 'system'
  }
 
  class { 'osx::global::natural_mouse_scrolling':
    enabled => false
  }

  class { 'osx::dock::hot_corners':
    bottom_left => "Put Display to Sleep",
    bottom_right => "Mission Control"
  }
  include osx::global::tap_to_click
  include osx::finder::show_hidden_files
  include osx::no_network_dsstores
  include osx::keyboard::capslock_to_control
  include osx::software_update
  include osx::global::expand_save_dialog
  include osx::global::expand_print_dialog
  include osx::global::enable_keyboard_control_access
  #class osx::recovery_message { 'If this Mac is found, please call 0408115527': }

  boxen::osx_defaults { 'Manage second click':
    user      => $::boxen_user,
    key       => 'enableSecondaryClick',
    domain    => 'com.apple.trackpad',
    value     => true,
  }

  repository { $dotfiles:
   source  => 'chris-horder/dotfiles',
   require => File[$my]
  }
}
#include projects::all
