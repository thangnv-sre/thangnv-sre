#!/bin/bash

# Update and install ZSH and required plugins
echo "Installing ZSH and plugins..."
sudo apt update && sudo apt install -y zsh zsh-autosuggestions zsh-syntax-highlighting

# Install Oh My ZSH
echo "Installing Oh My ZSH..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Set ZSH_CUSTOM if not already defined
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

# Install autosuggestions plugin
echo "Installing zsh-autosuggestions plugin..."
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions

# Install syntax-highlighting plugin
echo "Installing zsh-syntax-highlighting plugin..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

# Install fast-syntax-highlighting plugin
echo "Installing fast-syntax-highlighting plugin..."
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git $ZSH_CUSTOM/plugins/fast-syntax-highlighting

# Install autocomplete plugin
echo "Installing zsh-autocomplete plugin..."
git clone --depth 1 https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete

# Update .zshrc file to enable plugins
ZSHRC="$HOME/.zshrc"
if grep -q "plugins=(" "$ZSHRC"; then
    echo "Updating plugins in .zshrc..."
    sed -i 's/^plugins=(.*)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-autocomplete)/' "$ZSHRC"
else
    echo "Adding plugins to .zshrc..."
    echo 'plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-autocomplete)' >> "$ZSHRC"
fi

# Apply changes
echo "Applying changes..."
source "$ZSHRC"

echo "ZSH installation and configuration complete!"
