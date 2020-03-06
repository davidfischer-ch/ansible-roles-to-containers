# Ansible Library ... Containerized

Give you the power to build tailor-made container images fitting your use cases.

The official images are cookie cutter containers, sometimes you need more flexibility.

This library is aimed by the goal of providing you with the framework to build your own containers,
powered by all the awesomeness of the [ansible-roles](https://github.com/davidfischer-ch/ansible-roles).

My primary goal was to containerize my personal projects that are already fully automated with [Ansible](https://github.com/ansible/ansible), without reinventing the wheel with low-level, inexpressive language such as bash.

## Quickstart

Tested on [Linux Mint 19.3](https://linuxmint.com/).

Install [ansible-bender](https://github.com/ansible-community/ansible-bender), [buildah](https://github.com/containers/buildah) and [fuse-overlayfs](https://github.com/containers/fuse-overlayfs) on your machine:

```
$ cd bootstrap
bootstrap$ pip3 install ansible-bender  # Install Ansible Bender
bootstrap$ nano roles/requirements.yml  # You may wanna pin versions
bootstrap$ sh bootstrap.sh -e fuse_overlayfs_version=v0.7.7  # Change it as you wish :)
```

Build the Base container image:
```
$ cd base
base$ sh build.sh
```

Build the Nginx container image:
```
$ cd nginx
nginx$ nano roles/requirements.yml  # You may wanna pin versions
nginx$ nano build.yml               # Update configuration as you wish
nginx$ sh build.sh -e nginx_version=release-1.15.6  # Change it as you wish :)
```

### Remark

The scripts are running ansible-bender and buildah as root.

Its a quick & dirty hack to prevent buildah to use vfs instead of fuse-overlayfs as a fallback.
And I was facing the issue that that issue, and this quick hack to prevent it came to my mind.

NB: My home directory is encrypted with eCryptfs...

Contributions to avoid this issue are welcome!

Check with:

```
$ sudo buildah info
{
    "host": {
        "CgroupVersion": "v1",
        "Distribution": {
            "distribution": "linuxmint",
            "version": "19.3"
        },
        "MemTotal": 16659857408,
        "MenFree": 797863936,
        "OCIRuntime": "runc",
        "SwapFree": 0,
        "SwapTotal": 0,
        "arch": "amd64",
        "cpus": 12,
        "hostname": "ZenBookPro",
        "kernel": "4.15.0-88-generic",
        "os": "linux",
        "rootless": false,
        "uptime": "13h 35m 54.4s (Approximately 0.54 days)"
    },
    "store": {
        "ContainerStore": {
            "number": 1
        },
        "GraphDriverName": "overlay",
        "GraphOptions": [
            "overlay.mount_program=/usr/bin/fuse-overlayfs",
            "overlay.mountopt=nodev"
        ],
        "GraphRoot": "/var/lib/containers/storage",
        "GraphStatus": {
            "Backing Filesystem": "extfs",
            "Native Overlay Diff": "false",
            "Supports d_type": "true",
            "Using metacopy": "false"
        },
        "ImageStore": {
            "number": 16
        },
        "RunRoot": "/var/run/containers/storage"
    }
}
```

## Containers

### Build

The base image required by the other containers.

Status: POC

### Nginx

Build your own Nginx containers fitting your use cases!

Nginx from source with all awesome options of the [nginx role](https://github.com/davidfischer-ch/ansible-role-nginx) available.

Status: POC

#### TODO

- Cleanup even further stuff
- Further reduce number of deb-src?
- Do we really need two ports exposed?
- Find strategies to setup sites (at runtime? or build then extract? or volume?)
- Document how to use it (I have to use it first) :)

2014-2020 - David Fischer
