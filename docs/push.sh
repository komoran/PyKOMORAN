#!/usr/bin/env bash
# Push HTML files to gh-pages automatically.

# Fill this out with the correct org/repo
ORG=shineware
REPO=PyKOMORAN
# This probably should match an email for one of your users.
EMAIL=reserve.dev@gmail.com

set -e

# Clone the gh-pages branch outside of the repo and cd into it.
git clone -b gh-pages "https://$GH_TOKEN@github.com/$ORG/$REPO.git" gh-pages
cd gh-pages

# Update git configuration so I can push.
if [ "$1" != "dry" ]; then
    # Update git config.
    git config user.name "Travis Builder"
    git config user.email "$EMAIL"
fi

# Copy in the HTML.  You may want to change this with your documentation path.
cp -R ../docs/_build/html/* ./

# Add and commit changes.
git add -A .
git commit -m "Rebuild PyDocs"
if [ "$1" != "dry" ]; then
    # -q is very important, otherwise you leak your GH_TOKEN
    git push -q origin gh-pages
fi
