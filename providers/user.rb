#
# Cookbook Name:: gitolite
# Provider:: user
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

def load_current_resource
  @home_path = new_resource.home ||
    "/home/#{new_resource.username}"
end

action :create do
  next if skip_gitolite?
  user_resource     :create
  dir_resource      :create
  repo_resource     :sync
  ssh_key_resource  :create
  install_resource  :run
  setup_resource    :run

  new_resource.updated_by_last_action(true)
end

action :delete do
  user_resource   :remove

  new_resource.updated_by_last_action(true)
end

private

def skip_gitolite?
  path = @home_path + '/.gitolite'

  if ::File.exists? path
    Chef::Log.warn('Gitolite installation already exists!')
    true
  else
    Chef::Log.info('Starting Gitolite installation.')
    false
  end
end

def user_resource(exec_action)
  home_path = @home_path
  r = user new_resource.username do
    comment   new_resource.comment  if new_resource.comment
    home      home_path
    shell     new_resource.shell    if new_resource.shell
    supports  :manage_home => true
    action    :nothing
  end
  r.run_action(exec_action)
  new_resource.updated_by_last_action(true) if r.updated_by_last_action?
end

def dir_resource(exec_action)
  ["#{@home_path}/.ssh", "#{@home_path}/bin"].each do |dir|
    r = directory dir do
      owner       new_resource.username
      group       Etc.getpwnam(new_resource.username).gid unless new_resource.group
      mode        dir =~ %r{/\.ssh$} ? '0700' : '0755'
      recursive   true
      action      :nothing
    end
    r.run_action(exec_action)
    new_resource.updated_by_last_action(true) if r.updated_by_last_action?
  end
end

def repo_resource(exec_action)
  home_path = @home_path
  version ||= new_resource.version || node['gitolite']['version']
  my_reference = (version == 'stable' ? node['gitolite']['stable_version'] : 'master')

  r = git "clone the gitolite repository" do
    repository  node['gitolite']['repository_url']
    revision    my_reference
    user        new_resource.username
    group       Etc.getpwnam(new_resource.username).gid unless new_resource.group
    destination "#{home_path}/gitolite"
    action      :nothing
  end
  r.run_action(exec_action)
  new_resource.updated_by_last_action(true) if r.updated_by_last_action?
end

def ssh_key_resource(exec_action)
  home_path = @home_path
  ssh_key ||= new_resource.ssh_key || IO.read(new_resource.key_path)

  r = file "#{home_path}/gitolite-admin.pub" do
    owner     new_resource.username
    group     Etc.getpwnam(new_resource.username).gid unless new_resource.group
    content   ssh_key
    action    :nothing
  end
  r.run_action(exec_action)
  new_resource.updated_by_last_action(true) if r.updated_by_last_action?
end

def install_resource(exec_action)
  home_path = @home_path

  r = execute "gitolite/install -ln" do
    user      new_resource.username
    cwd       home_path
    command   "#{home_path}/gitolite/install -ln #{home_path}/bin"
    creates   "#{home_path}/bin/gitolite"
  end
  r.run_action(exec_action)
  new_resource.updated_by_last_action(true) if r.updated_by_last_action?
end

def setup_resource(exec_action)
  home_path = @home_path

  r = execute "gitolite setup -pk gitolite-admin.pub" do
    user      new_resource.username
    group     Etc.getpwnam(new_resource.username).gid unless new_resource.group
    cwd       home_path
    command   "#{home_path}/gitolite/src/gitolite setup -pk #{home_path}/gitolite-admin.pub"
    environment ({'HOME' => home_path})
  end
  r.run_action(exec_action)
  new_resource.updated_by_last_action(true) if r.updated_by_last_action?
end
