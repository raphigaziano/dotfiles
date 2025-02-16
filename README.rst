-1 Clone this repo:

   ::

       ~ $ git clone https://github.com/raphigaziano/dotfiles.git

-2 (Opt) Install packages (need root permissions):

   ::

      ~ $ ./scripts/getpkgs.sh

-3 Update config:

   ::

      ~ $ ./install.sh

-4 profit!

Notes:

Some vim plugins (nvim and lualine) require a Nerd Font to be installed to work
properly.

Some terminals (ie Ghostty) claim to come with NerdFonts included, so no
further action should be required with those. If using another terminal, then
see https://gist.github.com/matthewjberger/7dd7e079f282f8138a9dc3b045ebefa0 to
install a font (SubNote: install only one of those, as they each weigh a ton
and i don't care enough about fonts to waste that much space. JetBrainsMono is
fine).
