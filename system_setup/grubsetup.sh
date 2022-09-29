#!/bin/bash
set -e
if [ ! -f ../system/etc/grub.d/00_00_linuxenv_1_settings ]; then
  echo 'Wrong working directory'
  exit 1
fi
mount -o remount,rw /
mount -o remount,rw /boot
mount -o remount,rw /boot/efi
GRUB_PREFIX=
if [ -f "$GRUB_PREFIX"/etc/grub.d/00_header ]; then
  rm -rf "$GRUB_PREFIX"/etc/grub.d.bak
  mv -T "$GRUB_PREFIX"/etc/grub.d "$GRUB_PREFIX"/etc/grub.d.bak
fi
if [ ! -f "$GRUB_PREFIX"/etc/grub.d.bak/00_header ]; then
  echo 'grub.d backup is missing'
  exit 1
fi
rm -rf "$GRUB_PREFIX"/etc/grub.d
cp -rT ../system/etc/grub.d "$GRUB_PREFIX"/etc/grub.d
read -rp 'Font size (12)? ' FONT_SIZE
if [[ ! $FONT_SIZE =~ ^[1-9][0-9]*$ ]]; then
  echo 'Bad font size number'
  exit 1
fi
grub-mkfont -s "$FONT_SIZE" -o /boot/grubfont.pf2 /home/home/opt/JetBrainsMono/ttf/JetBrainsMono-Regular.ttf
LC_ALL=C grub-kbdcomp -o /boot/keymap.gkb dvorak

read -rsp 'Enter new password: ' PASS
echo
read -rsp 'Reenter password: ' REENTER
echo

if [ "$PASS" != "$REENTER" ]; then
  echo 'Mismatched passwords'
  exit 1
fi

PASS="$((echo "$PASS"; echo "$PASS") | grub-mkpasswd-pbkdf2 | tail -n1 | cut -f7 -d' ')"
unset REENTER
exec 3>"$GRUB_PREFIX"/etc/grub.d/00_00_linuxenv_3_system
chmod 700 /proc/self/fd/3

echo "#!/bin/sh
exec tail -n +3 \$0
set superusers=root
password_pbkdf2 root $PASS" >&3
unset PASS

enforce_root() {
  # $1 - mounted subfolder
  # $2 - variable name
  # $3 - partition name
  # Returns $DEV, $UUID, $NAME
  DEV=$(findmnt -no source -T "$1" 3>&-)
  UUID=$(blkid -o value -s UUID $DEV 3>&-)
  NAME=$2
  echo $3 UUID=$UUID at $DEV
  local HINT
  read -rp 'Where (beware of partitions not in disk order) is this partition (hd0,gptX)? ' HINT
  if [[ ! $HINT =~ ^hd[0-9],gpt[0-9]+$ ]]; then
    echo 'Expected hd0,gptX'
    exit 1
  fi
  echo "
search --no-floppy --fs-uuid --set=$NAME $UUID
if [ \"\$$NAME\" != \"$HINT\" ]; then
	echo '$3 UUID'
	set my_fail=1
fi" >&3
}

enforce_root /boot my_linux_boot 'Boot partition'
echo 'set root="$'"$NAME"\" >&3

enforce_root / my_linux_root 'Root partition'
echo "set $NAME=$DEV
export $NAME" >&3

enforce_root /boot/efi my_efi_root 'EFI partition'

echo "
if [ \"\$my_fail\" == 0 ]; then" >&3
exec 3>&-

rm -f /boot/grub/grubenv
update-grub2
grub-install
