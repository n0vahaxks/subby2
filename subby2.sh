#!/bin/bash

# Check if Sublist3r is installed
if ! [ -x "$(command -v sublist3r)" ]; then
  echo "Sublist3r is not installed. Installing now..."
  sudo apt-get update
  sudo apt-get install -y sublist3r
fi

# Check if Eyewitness is installed
if ! [ -x "$(command -v eyewitness)" ]; then
  echo "Eyewitness is not installed. Installing now..."
  sudo apt-get update
  sudo apt-get install -y eyewitness
fi

# Prompt user for target domain
read -p "Enter target domain: " domain

# Run Sublist3r to enumerate subdomains
sublist3r -d $domain -o subdomains.txt

# Run Eyewitness to take screenshots of each subdomain
while read subdomain; do
  eyewitness --web -f subdomains.txt --prepend-https --threads 10 --no-prompt
done <subdomains.txt

echo "Subdomain enumeration and screenshotting complete!"

