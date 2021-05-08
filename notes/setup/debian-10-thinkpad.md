# Hardware setup for Debian 10 (on a Thinkpad Carbon X1)

## Installing on encrypted LVM

Just works! If you have no other OS, guided partitioning will do
everything for you. If you want to keep Windows around, you'll need to
select manual partitioning and then, in the free space:

1. Make a small partition for `/boot` and a large one for encryption
2. Set up LVM after initializing the encrypted partition
3. Create some logical volumes for swap, `/`, `/home`, and so on

Note that as of 10.0.3 the transitional `cryptsetup` package is still
installed, so to tidy things up you can run:

    sudo apt remove --purge cryptsetup
    sudo apt-mark manual cryptsetup-run cryptsetup-initramfs

BUT! In 11 cryptsetup is the real thing again and cryptsetup-run is the
dummy.

# Firmware

Install the `firmware-linux-nonfree` package.

# Boot

Once the install is done, you'll notice grub's menu is ugly. The nice
default background image for grub is shipped on the root (or `/usr`)
partition, which is on encrypted LVM and can't be read before we boot
into the kernel and provide the encryption passphrase, so copy it from
`/usr/share/images/desktop-base` to `/boot`. Then add

    GRUB_BACKGROUND=/boot/desktop-grub.png

To `/etc/default/grub`. To get readable text in the boot menu, uncomment
the

    GRUB_GFXMODE=640x480

line. Finally, to replace the tiny text console between grub and full
bootup that asks for your disk encryption passphrase with a graphical
boot splash screen, follow the [instructions to enable
Plymouth](https://wiki.debian.org/plymouth), which is already installed
with the base system.

After all of these, run `update-grub`.

## Fixing post-boot console

To use a font that isn't incredibly tiny on WQHD, change these variables in
`/etc/default/console-setup` and reboot:

    CODESET="Uni3"
    FONTFACE="Terminus"
    FONTSIZE="16x32"

## Enabling hibernation

Install `pm-utils`. Then add `resume=/dev/mapper/yourvg-swap` or
whatever your swap volume is (`UUID=<your-swaps-uuid>` probably also
works) to the kernel command line in `/etc/default/grub`, run
`update-grub` again, and reboot.

## Fixing trackpad

By default, `xserver-xorg-input-synaptics` is not installed, so the
xorg.conf stuff to change scrolling direction will not have any effect.
To fix this, install it and restart X (`systemctl restart lightdm`).
