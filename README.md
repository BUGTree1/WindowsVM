
# Windows 11 VM Shell Scripts for Linux (works on my PC Arch btw)

## Dependencies

### Apps

qemu-system-x86_64

remote-viewer

### Files

win11.qcow2 - the virtual disk where windows will be installed

windows11.iso - iso with the windows 11 installer

virtio-win.iso - iso with virtio drivers for windows

linux.iso - (optional) linux iso that will be used when copying files

## Usage

To use run:

```console
$ ./all.sh
```

To copy files from virt folder (run a linux vm with the folder as disk and windows disk):

```console
$ ./mount.sh
```
