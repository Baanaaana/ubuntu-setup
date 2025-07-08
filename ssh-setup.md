# GitHub SSH Setup Guide for Linux

This guide shows you how to connect a GitHub repository to a folder in Linux using SSH authentication.

## 1. Generate SSH Key (if you don't have one)

```bash
ssh-keygen -t ed25519 -C "rene@rrcommerce.com"
# Press Enter to save to default location (~/.ssh/id_ed25519)
# Enter a passphrase or press Enter for no passphrase
```

**Alternative for older systems:**
```bash
ssh-keygen -t rsa -b 4096 -C "rene@rrcommerce.com"
```

## 2. Add SSH Key to GitHub

```bash
# Copy the public key to clipboard
cat ~/.ssh/id_ed25519.pub
```

1. Go to GitHub → Settings → SSH and GPG keys
2. Click "New SSH key"
3. Paste the public key and save

## 3. Test SSH Connection

```bash
# Test the connection to GitHub
ssh -T git@github.com
```

You should see: `"Hi Baanaaana! You've successfully authenticated, but GitHub does not provide shell access."`

## 4. Clone Repository to Your Folder

```bash
# Navigate to where you want the repository
cd /path/to/your/desired/folder

# Clone using SSH
git clone git@github.com:Baanaaana/rrc-hub.git

# Or clone into a specific folder name
git clone git@github.com:Baanaaana/rrc-hub.git /opt
```

## 5. Alternative: Initialize Existing Folder with Remote

If you already have a folder with files:

```bash
# Navigate to your existing folder
cd /path/to/your/existing/folder

# Initialize git repository
git init

# Add remote origin using SSH
git remote add origin git@github.com:Baanaaana/repository-name.git

# Add and commit your files
git add .
git commit -m "Initial commit"

# Push to GitHub
git push -u origin main
```

## 6. Configure Git (if not already done)

```bash
git config --global user.name "René van 't Hoff"
git config --global user.email "rene@rrcommerce.com"
```

## 7. Working with the Repository

```bash
# Pull latest changes
git pull origin main

# Make changes, add, commit, and push
git add .
git commit -m "Your commit message"
git push origin main
```

## Troubleshooting SSH Issues

### Permission Issues
If you encounter permission issues:

```bash
# Check SSH key permissions
ls -la ~/.ssh/

# Fix permissions if needed
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub
```

### Multiple SSH Keys
If you have multiple SSH keys:

```bash
# Create/edit SSH config
nano ~/.ssh/config

# Add configuration
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519
```

### Common Issues

- **Permission denied (publickey)**: Check if your SSH key is added to GitHub and has correct permissions
- **Host key verification failed**: Run `ssh-keyscan github.com >> ~/.ssh/known_hosts`
- **Repository not found**: Verify the repository name and that you have access to it

## Quick Reference Commands

```bash
# Generate new SSH key
ssh-keygen -t ed25519 -C "rene@rrcommerce.com"

# View public key
cat ~/.ssh/id_ed25519.pub

# Test GitHub connection
ssh -T git@github.com

# Clone repository
git clone git@github.com:Baanaaana/repo.git

# Add remote to existing folder
git remote add origin git@github.com:Baanaaana/repo.git

# Basic git workflow
git add .
git commit -m "message"
git push origin main
```

---

**Note**: Replace `username` and `repository-name` with your actual GitHub username and repository name.