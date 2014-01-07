#
# Cookbook Name:: gitolite
# Attribute:: default
#
# Author:: Julio Napuri <julionc@gmail.com> 
#
# Copyright 2012, Julio Napuri
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Cookbook Settings
default['gitolite']['repository_url'] = 'git://github.com/sitaramc/gitolite.git'
default['gitolite']['stable_version'] = 'v3.5.3.1'

# Custom Settings
default['gitolite']['username'] = 'git'
default['gitolite']['group'] = node['gitolite']['username']
default['gitolite']['home'] = "/home/#{node['gitolite']['username']}"
default['gitolite']['version'] = 'stable' # dev

# Required Settings
default['gitolite']['admin'] = nil
# Choose ssh_key or ssh_path
default['gitolite']['ssh_key'] = nil
default['gitolite']['ssh_path'] = nil
