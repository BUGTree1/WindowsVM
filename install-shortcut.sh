#!/bin/bash

VM_PATH="$PWD"

cat > Windows_VM.desktop << EOL
[Desktop Entry]
Comment[en_US]=a windows VM
Comment=a windows VM
Exec=$VM_PATH/all.sh
GenericName[en_US]=Windows VM
GenericName=Windows VM
Icon=im-msn
MimeType=
Name[en_US]=Windows VM
Name=Windows VM
Path=$VM_PATH
StartupNotify=true
Terminal=false
TerminalOptions=
Type=Application
X-KDE-SubstituteUID=false
X-KDE-Username=
EOL

cp Windows_VM.desktop ~/.local/share/applications
