name             "gitolite"
maintainer       "Julio Napuri"
maintainer_email "julionc@gmail.com"
license          "Apache 2.0"
description      "Installs and configures gitolite"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.2"

recipe "gitolite",        "This recipe installs Gitolite dependencies perl and git."
recipe "gitolite::basic", "Sets up the gitolite basic installation."

%w( ubuntu debian ).each do |os|
  supports os
end

%w( git perl ).each do |cb|
  depends cb
end
