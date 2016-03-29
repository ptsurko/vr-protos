#!/bin/bash

# This makes sure, that we don't deploy pull requests to gh-pages :-)
if [ $TRAVIS_PULL_REQUEST != false ];
  then
  echo "Not deploying test-run for a pull request"
  exit 0
fi
(
  echo "Pushing build to ${GH_REF} gh-pages branch."
  git checkout -b gh-pages
  # inside this git repo we'll pretend to be a new user
  git config user.name "${GIT_NAME}"
  git config user.email "${GIT_EMAIL}"

  # The first and only commit to this new Git repo contains all the
  # files present with the commit message "Deploy to GitHub Pages".
  git add .
  git add bower_components -f
  git add node_modules -f

  git commit -m "Deployed to Github Pages"

  git push --force "https://${GH_TOKEN}@${GH_REF}" gh-pages:gh-pages

  echo "New gh-pages branch has been pushed to ${GH_REF}."
)
