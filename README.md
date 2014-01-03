# hhvm-cookbook

## Requirements

* Chef `>= 11.6.0`
* Ruby `>= 1.9.3`

## Platforms

* Debian `7`
* Ubuntu `12.04`, `13.10`
* CentOS `6.4`

**The cookbook was tested on the previous platforms using the provided [`Vagrantfile`](Vagrantfile).**

## Cookbooks

### Requirements

* [apt cookbook](https://github.com/opscode-cookbooks/apt)
* [yum cookbook](https://github.com/opscode-cookbooks/yum)

**All the requirements are decribed in the cookbook's [`metadata.rb`](metadata.rb) file and are locked using Berkshelf's lock file.**

### Recipes

#### hhvm::default

This will install HHVM using packages which is the default installation method.

#### hhvm::package

This will install HHVM using packages which is the default installation method.

### Attributes

| Attribute                                         | Default                      | Description/Values                                                      |
| ------------------------------------------------- | ---------------------------- | ----------------------------------------------------------------------- |
| `node['hhvm']['installation_type']`               | package                      | Installation method (`package` or `source`)                             |
| **Package installation**                          |                              |                                                                         |
| `node['hhvm']['enable_fastcgi']`                  | true                         | Wether to install `hhvm-fastcgi` on supported platforms (Debian/Ubuntu) |
| **Source installation**                           |                              |                                                                         |
| `node['hhvm']['source']['revision']`              | master                       | Revision to checkout when installing from sources                       |
| `node['hhvm']['source']['libevent_revision']`     | release-1.4.14b-stable       | libevent version to checkout to build HHVM                              |
| `node['hhvm']['source']['layout']['working_dir']` | /usr/src                     | Directory in which repositories will be cloned                          |
| `node['hhvm']['source']['layout']['prefix']`      | /usr                         | Prefix used when building HHVM                                          |
| `node['hhvm']['source']['dependencies'][...]`     | _very long list of packages_ | List of packages to install before being able to build HHVM             |

**All the default attributes are available in the [`attributes/default.rb`](attributes/default.rb) file.**

## License

See [LICENSE](LICENSE) file.
