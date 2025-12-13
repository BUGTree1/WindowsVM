
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

### To install windows 

First run to open the windows installer:

```console
$ ./all-install.sh
```

Now go to repair my pc and open cmd and run the command:

```console
$ setupprep.exe /product server
```

Proceed with the installation.

### To use run already installed windows 

Run:

```console
$ ./all.sh
```

### To copy files from a folder to the VM

Run a linux vm with the `virt` folder as a disk and the windows disk:

```console
$ ./mount.sh
```
