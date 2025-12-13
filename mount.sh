#!/bin/bash

LINUX_ISO="linux.iso"

qemu-system-x86_64 -enable-kvm -machine q35 -smp 4 -cdrom "$LINUX_ISO" -m 4G -drive "file=fat:rw:virt" -hdb win11.qcow2 -boot d -cpu host
