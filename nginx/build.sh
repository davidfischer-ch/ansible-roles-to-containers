#!/usr/bin/env bash

set -e

sudo rm -rf roles/lib 2>/dev/null
ansible-galaxy install -r roles/requirements.yml --roles-path roles --force

sudo \
ANSIBLE_FILTER_PLUGINS=roles/lib/plugins/filter:/usr/share/ansible/plugins/filter \
ANSIBLE_LIBRARY=roles/lib/library:/usr/share/ansible/plugins/modules \
ANSIBLE_ROLES_PATH=roles \
ANSIBLE_STDOUT_CALLBACK=debug \
ansible-bender build build.yml "$@"
