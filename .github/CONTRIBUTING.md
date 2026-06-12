# Contributing to steam-rom-manager

## Gotchas

* While contributing make sure to make all your changes before creating a Pull Request, as our pipeline builds each commit after the PR is open.
* Read, and fill the Pull Request template
  * If this is a fix for a typo (in code, documentation, or the README) please file an issue and let us sort it out. We do not need a PR
  * If the PR is addressing an existing issue include, closes #\<issue number>, in the body of the PR commit message
* If you want to discuss changes, you can also bring it up in [#dev-talk](https://discordapp.com/channels/354974912613449730/757585807061155840) in our [Discord server](https://linuxserver.io/discord)

## Common files

| File | Use case |
| :----: | --- |
| `Dockerfile` | Dockerfile used to build amd64 images |
| `Jenkinsfile` | This file is a product of our builder and should not be edited directly. This is used to build the image |
| `jenkins-vars.yml` | This file is used to generate the `Jenkinsfile` mentioned above, it only affects the build-process |
| `package_versions.txt` | This file is generated as a part of the build-process and should not be edited directly. It lists all the installed packages and their versions |
| `README.md` | This file is a product of our builder and should not be edited directly. This displays the readme for the repository and image registries |
| `readme-vars.yml` | This file is used to generate the `README.md` |

## Readme

If you would like to change our readme, please __**do not**__ directly edit the readme, as it is auto-generated on each commit.
Instead edit the [readme-vars.yml](https://github.com/linuxserver/docker-steam-rom-manager/edit/master/readme-vars.yml).

These variables are used in a template for our [Jenkins Builder](https://github.com/linuxserver/docker-jenkins-builder) as part of an ansible play.
Most of these variables are also carried over to [docs.linuxserver.io](https://docs.linuxserver.io/images/docker-steam-rom-manager)

### Fixing typos or clarify the text in the readme

There are variables for multiple parts of the readme, the most common ones are:

| Variable | Description |
| :----: | --- |
| `project_blurb` | This is the short excerpt shown above the project logo. |
| `app_setup_block` | This is the text that shows up under "Application Setup" if enabled |

### Adding new parameters to the readme

There are a couple of variables that allow for adding parameters to the readme.

| Variable | Description |
| :----: | --- |
| `param_*` | These are for mandatory parameters |
| `opt_param_*` | These are for optional parameters |
| `cap_param_*` | These are for parameters requiring specific capabilities or system flags |
| `custom_*` | These are for any other types of run parameters |

These should all match up to docker run command parameters with the exception of `cap_param_` which is its own table.

## Dockerfiles

We use multiple Dockerfiles in our repos for the different architectures we support.
We do all of our base builds on `amd64` and our other Dockerfiles use cross compilation from this builder to the architecture being built.
Use the existing files as your basis when creating a modification or for any new files.
