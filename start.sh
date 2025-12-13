#!/bin/bash
DISK_IMG="win11.qcow2"
VIRTIO_ISO="virtio-win.iso"
WIN11_ISO="windows11.iso"
OVMF_CODE="./OVMF_CODE.fd"
OVMF_VARS="./OVMF_VARS.fd"

#    -boot d \
#    -cdrom "$WIN11_ISO" \
#    -drive file="$VIRTIO_ISO",media=cdrom \

qemu-system-x86_64 \
    -machine q35 \
    -enable-kvm \
    -cpu host \
    -m 5G \
    -smp 4 \
    -drive file="$DISK_IMG",format=qcow2,if=virtio \
    -drive if=pflash,format=raw,readonly=on,file="$OVMF_CODE" \
    -drive if=pflash,format=raw,file="$OVMF_VARS" \
    -device virtio-vga-gl \
    -display egl-headless,rendernode=/dev/dri/renderD129 \
    -vga none \
    -spice port=5900,addr=127.0.0.1,disable-ticketing=on \
    -device virtio-serial-pci \
    -device virtserialport,chardev=spicechannel0,name=com.redhat.spice.0 \
    -chardev spicevmc,id=spicechannel0,name=vdagent \
    -audiodev spice,id=audio0 \
    -device ich9-intel-hda,id=sound0 \
    -device hda-output,audiodev=audio0 \
    -device qemu-xhci,id=usb \
    -device usb-tablet,bus=usb.0 \
    -netdev user,id=net0 \
    -device virtio-net-pci,netdev=net0,rombar=0 \
    -D qemu.log \
    -d guest_errors \
    -monitor unix:/tmp/qemu-monitor-socket,server,nowait \
    -nodefaults

