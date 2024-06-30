#! /usr/bin/env nix-shell
#! nix-shell -i bash -p git -p nh
set -e

HOSTNAME=$(hostname)

# --------------------------------- Functions -------------------------------- #

get_gen() {
  sudo nix-env --list-generations --profile /nix/var/nix/profiles/system | awk '/current/ {print $1}'
}

# ---------------------------------- Script ---------------------------------- #

# Add changes
git add .

# Lock flake inputs
nix flake lock --option warn-dirty false

# Check if the most recent commit message contains "PREBUILD"
if git log -1 --pretty=%B | grep -q "PREBUILD"; then
  # Amend the existing PREBUILD commit
  git commit -aq --allow-empty --amend -m "$HOSTNAME: PREBUILD"
else
  # Create a new PREBUILD commit
  git commit -aq --allow-empty -m "$HOSTNAME: PREBUILD"
fi

# Run nixos-rebuild
prev_gen=$(get_gen)
nh os switch .
next_gen=$(get_gen)

# Set commit message
git commit -aqn --allow-empty --amend -m "$HOSTNAME: $prev_gen -> $next_gen"

# Push changes
# git push -q

exit 0
