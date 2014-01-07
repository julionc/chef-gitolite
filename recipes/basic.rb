#
# Cookbook Name:: gitolite
# Recipe:: basic
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

include_recipe "gitolite::default"

username = node['gitolite']['username']

gitolite_user username do
  home      node['gitolite']['home']
  version   node['gitolite']['version']
  ssh_key   node['gitolite']['ssh_key']
end
