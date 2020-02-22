require 'pygments'

# use a custom Pygments installation (directory that contains pygmentize)
Pygments.start `dirname "$(which pygmentize)"`
