# Using the Emacs key theme with GTK+ 3 and XFCE

In addition to the normal dotfiles, under XFCE, you need to run this:

    xfconf-query -c xsettings -n -p /Gtk/KeyThemeName -t string -s Emacs
