# hhvm

## Requirements

* Chef `>= 11.6.0`
* Ruby `>= 1.9.3`

## Platforms

|              | Debian 7   | Ubuntu 12.04   | Ubuntu 13.10   | CentOS 6.4   |
| -----------: | :--------: | :------------: | :------------: | :----------: |
| **Source**   | X          | X              | X              |              |
| **Package**  | X          | X              | X              | X            |

**The cookbook was tested on the previous platforms using the provided [`Vagrantfile`](Vagrantfile).**

## Cookbooks

### Requirements

* [apt cookbook](https://github.com/opscode-cookbooks/apt)
* [yum cookbook](https://github.com/opscode-cookbooks/yum)

**All the requirements are decribed in the cookbook's [`metadata.rb`](metadata.rb) file and are locked using Berkshelf's lock file.**

### Attributes

| Attribute                                         | Default                                | Description/Values                                                         |
| ------------------------------------------------- | -------------------------------------- | -------------------------------------------------------------------------- |
| `node['hhvm']['installation_type']`               | package                                | Installation method ([`package`](#hhvmpackage) or [`source`](#hhvmsource)) |
| **Source installation**                           |                                        |                                                                            |
| `node['hhvm']['source']['make_jobs']`             | 1                                      | Number of parallel jobs when running `make` commands                       |
| `node['hhvm']['source']['hhvm_repository']`       | git://github.com/facebook/hhvm.git     | HHVM git repository URL                                                    |
| `node['hhvm']['source']['hhvm_revision']`         | master                                 | Revision to checkout when installing from sources                          |
| `node['hhvm']['source']['libevent_repository']`   | git://github.com/libevent/libevent.git | libevent git repository URL                                                |
| `node['hhvm']['source']['libevent_revision']`     | eb8122f26 (release-1.4.14b-stable)     | libevent version to checkout to build HHVM                                 |
| `node['hhvm']['source']['layout']['working_dir']` | /usr/src                               | Directory in which repositories will be cloned                             |
| `node['hhvm']['source']['layout']['prefix']`      | /usr                                   | Prefix used when building HHVM                                             |
| `node['hhvm']['source']['dependencies'][...]`     | _very long list of packages_           | List of packages to install before being able to build HHVM                |

**All the default attributes are available in the [`attributes/default.rb`](attributes/default.rb) file.**

### Recipes

#### hhvm::default

This will install HHVM using packages which is the default installation method.

#### hhvm::package

This will install HHVM using packages which is the default installation method.

#### hhvm::source

This will install HHVM from sources.

## License

See [LICENSE](LICENSE) file.
