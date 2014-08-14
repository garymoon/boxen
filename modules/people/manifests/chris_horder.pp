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
 
  #file { "/usr/local/bin/subl" :
  #  ensure  => link,
  #  target  => '/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl',
  #  require => 'Class[sublime_text_2]'
  #}

  repository { $dotfiles:
   source  => 'chris-horder/dotfiles',
   require => File[$my]
  }
}
#include projects::all
