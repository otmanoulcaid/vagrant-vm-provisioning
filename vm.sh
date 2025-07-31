#!/bin/bash

set -e

print_help() {
    echo "Usage: vm <env> <option>"
    echo "  env    => java, nodejs"
    echo "  option => up, ssh, halt, reload, destroy, status, suspend, resume, ssh-config"
    exit 1
}

if [ ! -d "$HOME/vms" ]; then
    mkdir -p "$HOME/vms"
    cd "$HOME/vms"
    git clone git@github.com:otmanoulcaid/vagrant-vm-provisioning.git > /dev/null 2>&1
fi

if [ $# -eq 0 ]; then
    echo "Error: No arguments provided."
    print_help
fi

case "$1" in
    nodejs)
        cd "$HOME/vms/vagrant-vm-provisioning/ubuntu-nodejs-env"
        ;;
    java)
        cd "$HOME/vms/vagrant-vm-provisioning/ubuntu-java-env"
        ;;
    *)
        echo "Error: Invalid environment '$1'"
        print_help
        ;;
esac

if [ $# -lt 2 ]; then
    echo "Error: Missing command option."
    print_help
fi

case "$2" in
    up)
        vagrant up 2> /dev/null
        ;;
    ssh)
        vagrant ssh
        ;;
    halt)
        vagrant halt
        ;;
    reload)
        vagrant reload
        ;;
    destroy)
        vagrant destroy -f
        ;;
    status)
        vagrant status
        ;;
    suspend)
        vagrant suspend
        ;;
    resume)
        vagrant resume
        ;;
    ssh-config)
        vagrant ssh-config
        ;;
    *)
        echo "Error: Invalid command option '$2'"
        print_help
        ;;
esac
