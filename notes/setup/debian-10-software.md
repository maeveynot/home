# Installation

Pick a desktop environment in tasksel (I'm currently using XFCE). There
are a whole lot of packages that don't ship on a standard desktop
install. This will fill in a few important things:

    sudo apt install $(cat ~/notes/apt-basic-packages.txt)

## SSH and UFW

SSH is the only service we want to expose. If it was not installed via
tasksel, run `sudo apt install openssh-server`. Then run:

    sudo apt install ufw
    sudo ufw enable
    sudo sed -i 's/^#\(PasswordAuthentication\) yes/\1 no/' /etc/ssh/sshd_config
    systemctl restart ssh
    sudo ufw allow ssh

## Repositories

Add these to `/etc/apt/sources.list`:

    deb http://deb.debian.org/debian buster-backports main
    deb http://www.deb-multimedia.org buster main non-free

Note that [deb-multimedia](http://www.deb-multimedia.org) requires
downloading a keyring package over insecure HTTP. See their website for
details. As of version `2016.8.1` the sha256sum of this .deb is
allegedly:

    9faa6f6cba80aeb69c9bac139b74a3d61596d4486e2458c2c65efe9e21ff3c7d

# Third Party Stuff

Some things, mostly non-free, need to be installed separately:

## Firefox

Until backports of
[Firefox](https://www.mozilla.org/en-US/firefox/linux/) stable to Debian
stable happen, I'm just putting the release builds in my `~/opt`. While
it is possible to install to `/opt` and share the binaries between local
users, this makes automatic updates impossible (you have to extract a
tarball as root), and it's not possible to write a `.desktop` file that
works for multiple paths (so the one in this repository is hardcoded
with `/home/maeve`).

## Google Chrome

The [Chrome](https://www.google.com/chrome/) download page now offers a
.deb that automatically sets up a repo (probably to get you to click
through the EULA), but this should still work:

    curl https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
    sudo apt update
    sudo apt install google-chrome-stable

# Node.js (from Nodesource)

Download and inspect the script (bump the version from 10.x to newer LTS
as needed):

    curl -o setup.sh -L https://deb.nodesource.com/setup_10.x

Run the script:

    sudo -E bash setup.sh

The script does an `apt update`, but apt will not automatically upgrade if you
have installed the Ubuntu-distributed nodejs package. In that case, run:

    sudo apt install nodejs

## Slack

[Download the Slack package](https://slack.com/downloads/linux) and
install it with `sudo apt install ./slack-desktop-VERSION-ARCH.deb`.
This will add a repository.

## Signal

[Signal](https://signal.org/download/) has a repository:

    curl -s https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -
    echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list
    sudo apt update && sudo apt install signal-desktop

## Keybase

[Download the Keybase package](https://keybase.io/docs/the_app/install_linux)
and install it with `sudo apt install ./keybase_ARCH.deb`. This will add a
repository.

## Wire

[Wire's
instructions](https://github.com/wireapp/wire-desktop/wiki/How-to-install-Wire-for-Desktop-on-Linux)
are somewhat hidden on the download page:

     wget -q https://wire-app.wire.com/linux/releases.key -O- | sudo apt-key add -
     echo "deb [arch=amd64] https://wire-app.wire.com/linux/debian stable main" | sudo tee /etc/apt/sources.list.d/wire-desktop.list
     sudo apt update && sudo apt install wire-desktop

## Spotify

[Spotify](https://www.spotify.com/us/download/linux/) has a repository:

    curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
