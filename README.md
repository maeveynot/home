# Maeve's $HOME

Yes, this is my home directory, as a Git repository. It contains my
dotfiles, my `~/bin`, other miscellaneous things I want on all my
workstations (yes, some submodules), and a gitignored directory layout
for everything else.

I'm not the first to have done this, by far. My long-term memory is
awful in general, but I recall some prominent Debian developers talking
about their implementations of the idea back when the source control
system available to do it in was CVS, and then SVN.

My goal is to be able to clone this repository on any new machine (or
new local user, fresh reinstall, VM, etc) and get working right away.
However, not everything can be completely configured with dotfiles these
days, and I'll probably be setting up system-wide stuff at the same
time, so I'm attempting to keep track of other steps in `~/notes/setup`.

# Installation and Usage

(This section is a note to myself; I don't actually want anyone else to
use this repository unmodified. If you would like to crib any parts of
it for your own use, though, the ISC license is below.)

 1. [Generate a SSH
    keypair](https://raw.githubusercontent.com/maeveynot/home/HEAD/bin/gen-ssh-key)
    for GitHub access on the new machine (`gen-ssh-key github
    github.com/maeveynot`) and associate it with my GitHub account. Add
    it to ssh-agent.
 2. Clone this repository to a temporary directory (this will attempt to
    use any key in the agent, since `.ssh/config` does not exist yet).
 3. Move all contents of the temporary directory, including `.git`, into
    `$HOME`. My home directory is now a clone of this repository.

When adding new files, remember to use `git add --force` for anything
under a gitignored directory such as `~/.config`.

# Miscellaneous

The default branch of this repository is `main` and Git is configured to
use that for all other newly-initialized repositories. Stop using
`master`; it is not an acceptable metaphor.

I periodically rebase heavily to reduce accumulated cruft from my
opinions on what configuration I want evolving over time. If something
is stable it will eventually become a single commit.

Lots of scripts in `bin` are very old and not that useful, and just here
for sentimental value since they were in my first dotfiles repository.

# License

Copyright 1997-2020 Maeve Andrews

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
