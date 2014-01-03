# hhvm-cookbook

## Requirements

* Chef `>= 11.6.0`

## Platforms

* Debian `7`
* Ubuntu `12.04`, `13.10`
* CentOS `6.4`

**The cookbook was tested on the previous platforms using the provided `Vagrantfile`.**

## Cookbooks

### Requirements

* [apt cookbook](https://github.com/opscode-cookbooks/apt)
* [yum cookbook](https://github.com/opscode-cookbooks/yum)

**All the requirements are decribed in the cookbook's `metadata.rb` file and are locked using Berkshelf's lock file.**

### Recipes

#### hhvm::default

This will install HHVM using packages which is the default installation method.

#### hhvm::package

This will install HHVM using packages which is the default installation method.

### Attributes

| Attribute                          | Default | Description/Values                                                      |
| ---------------------------------- | ------- | ----------------------------------------------------------------------- |
| node['hhvm']['installation_type']  | package | Installation method (`package` or `source`)                             |
| **Package installation**           |         |                                                                         |
| node['hhvm']['enable_fastcgi']     | true    | Wether to install `hhvm-fastcgi` on supported platforms (Debian/Ubuntu) |
| **Source installation**            |         |                                                                         |
| node['hhvm']['source']['revision'] | master  | Revision to checkout when installing from sources                       |

## License

See [LICENSE](LICENSE) file.
