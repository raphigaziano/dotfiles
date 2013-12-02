pip install git+git://github.com/Lokaltog/powerline
# Using patched fonts for xterm. Recommended way is fontconfig
# but xterm doenst suport it.
# see https://powerline.readthedocs.org/en/latest/installation/linux.html#installation-linux

fc-cache -vf $HOME/.fonts

echo 'now set terminal font to one *for powerline font and restart x'
echo 'You might also need to run the folowing command from vim cmd mode:'
echo 'python from powerline import setup as powerline_setup'
echo 'powerline_setup()'
echo 'del powerline_setup()'
