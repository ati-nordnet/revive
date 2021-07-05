# #!/bin/sh
myname="Atila Aliosmanov"
email="atispor@gmail.com"
echo "Creating an SSH key for you..."
ssh-keygen -t rsa -b 4096 -C $email
# Start the ssh-agent in the background.
eval "$(ssh-agent -s)"

touch ~/.ssh/config
# prefer a rebase workflow
git config --global pull.rebase merges

echo "Host *\n  AddKeysToAgent yes\n  UseKeychain yes\n  IdentityFile ~/.ssh/id_rsa" >> ~/.ssh/config

# # Add your SSH private key to the ssh-agent and store your passphrase in the keychain
ssh-add -K ~/.ssh/id_rsa

echo "Please add this public key to Github \n"
echo "https://github.com/account/ssh \n"
pbcopy < ~/.ssh/id_rsa.pub
echo "ssh key COPIED TO CLIPBOARD!"
read -p "Press [Enter] key after this..."