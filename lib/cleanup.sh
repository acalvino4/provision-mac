# Removes anything that has been added to files outside this repo
# Does not remove installed software

# Will be called at uninstall, but also updates.
# This ensures any additions to the system outside the installation directory can be cleanly move or be removed at any time.

[ -f ~/.vimrc ] && sed -i '' '/" Managed by rock/d' ~/.vimrc
