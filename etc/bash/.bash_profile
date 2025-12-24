# # add keychain for git
# if [ `which keychain` ]; then
#     eval `keychain --eval --agents ssh id_rsa_evogit`
# else
#     echo "keychain not installed"
# fi

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi
