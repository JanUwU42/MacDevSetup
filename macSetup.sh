#!/bin/zsh

# macOS Development Environment Setup Script
echo "Starting macOS development environment setup..."

# Install Xcode Command Line Tools
echo "Installing Xcode Command Line Tools..."
xcode-select --install

# Install & update Homebrew
echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew update

# Install development tools
echo "Installing development tools..."
dev_tools=("git" "node" "go" "hugo" "docker" "btop" "spicetify-cli" "rust" "helix" "neovim" "yarn" "awscli" "aws-sam-cli" "fastfetch" "vite" "openjdk")

for tool in "${dev_tools[@]}"
do
    brew install "$tool"
done

# Install Oh My Zsh
echo "Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install development applications (Casks)
echo "Installing development applications..."
dev_apps=("zed" "rancher" "vscodium" "kitty" "wezterm" "jetbrains-toolbox" "insomnia" "zen" "brave-browser" "spotify" "mongodb-compass" "rectangle" "maccy" "logseq" "anytype" "vlc" "hiddenbar" "mac-mouse-fix" "latest" "localsend")

for app in "${dev_apps[@]}"
do
    brew install --cask "$app"
done

# Generate SSH key for Git
echo "Generating SSH key for Git..."
if [ ! -f ~/.ssh/id_ed25519 ]
then
    ssh-keygen -t ed25519 -C "TODO:Your-Email@example.com" -f ~/.ssh/id_ed25519 -N ""

    # Start SSH agent and add key
    eval "$(ssh-agent -s)"
    ssh-add --apple-use-keychain ~/.ssh/id_ed25519

    echo "SSH key generated. Public key:"
    echo "$(cat ~/.ssh/id_ed25519.pub)"
    echo ""
    echo "Add this key to GitLab."
else
    echo "SSH key already exists, skipping generation."
fi

# Configure Git
echo "Configuring Git..."
git config --global user.name "TODO:Your Full Name"
git config --global user.email "TODO:Your-Email@example.com"
# TODO: Replace with your Git hosting URL if needed
# git config --global url."ssh://git@your-git-host.com".insteadOf "https://your-git-host.com"
git config --global commit.gpgsign true
git config --global gpg.format ssh
git config --global user.signingkey ~/.ssh/id_ed25519.pub

# Create CodeProjects directory and clone repositories
echo "Setting up CodeProjects directory..."
mkdir -p ~/CodeProjects
cd ~/CodeProjects

echo "Cloning repositories..."
# Format: "repo-url:custom-name" or just "repo-url" for default name
repos=(
      "TODO:git@github.com:username/repo1.git:custom-name"
      "TODO:git@github.com:username/repo2.git"
      # Add your repositories here
)

for repo in "${repos[@]}"
do
    if [[ "$repo" == *":"* ]]
    then
        repo_url="${repo%:*}"
        custom_name="${repo#*:}"
        echo "Cloning $repo_url as $custom_name..."
        git clone "$repo_url" "$custom_name"
    else
        echo "Cloning $repo..."
        git clone "$repo"
    fi
done

cd ~

echo "Setup complete! Please restart your terminal."