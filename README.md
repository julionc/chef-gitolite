# gitolite

This cookbook sets up [gitolite][gitolite] service.
Also includes a LWRP.

[![Build Status](https://secure.travis-ci.org/julionc/chef-gitolite.png)](http://travis-ci.org/julionc/chef-gitolite)

Requirements
============

## Platform

 * Debian / Ubuntu

## Cookbooks

 * perl
 * git

Recipes
=======

* `gitolite` - This recipe installs Gitolite dependencies perl and git.
* `gitolite::basic` - Sets up the gitolite basic installation.

Attributes
==========
See `attributes/default.rb`.

 * `node['gitolite']['username']` - The dedicated userid for gitolite.
 * `node['gitolite']['group']` - The group for your gitolite user. (optional)
 * `node['gitolite']['admin']` - The admin name for your gitolite instance.
 * `node['gitolite']['version']` - Set dev or stable version.
 * `node['gitolite']['ssh_key']` - Set the ssh_key string.
 * `node['gitolite']['ssh_path']` - Set the ssh_path path.

Resources/Providers
===================

The cookbook contains an LWRP, `gitolite_user`. This can be used
with the normal Chef service resource.

gitolite\_user
----------------

Manage a gitolite resource (installation).

### Actions:

| Action    | Description        | Default |
|-----------|--------------------|---------|
| *create*  | Create the user.   | Yes     |
| *remove*  | Destroy the user.  |         |

### Parameter Attributes:

| Parameter  | Description                | Default |
|------------|----------------------------|---------|
| *group*    | Group to sets              |         |
| *home*     | The HOME path              |         |
| *version*  | gitolite version           | stable  |
| *ssh\_key*  | SSH Key string             |         |
| *ssh\_path* | SSH Path                   |         |

### LWRP Examples

Create a gitolite user (option #1)

```ruby
gitolite_user 'git' do
  home    '/home/git'
  version 'stable' #or dev
  ssh_key 'ssh-rsa...'
end
```

Create a gitolite user (option #2)

```ruby
gitolite_user 'git' do
  home    '/home/git'
  version 'stable' #or dev
  key_path '/home/admin/.ssh/id_rsa.pub'
end
```

Remove a gitolite user

```ruby
gitolite_user 'git' do
  action :delete
do
```

Usage
=====

Simply include `recipe[gitolite]` in your run_list and the
`gitolite_user` resource will be available.
See examples of the LWRP usage above.

Development
===========

* Source hosted at [GitHub][repo]
* Report issues/Questions/Feature requests on [GitHub Issues][issues]

Pull requests are very welcome! Make sure your patches are well tested.
Ideally create a topic branch for every seperate change you make.

License and Author
==================

Author:: Julio Napuri <julionc@gmail.com>

Copyright:: 2012, Julio Napuri

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[gitolite]:     https://github.com/sitaramc/gitolite

[repo]:         https://github.com/julionc/chef-gitolite
[issues]:       https://github.com/julionc/chef-gitolite/issues
