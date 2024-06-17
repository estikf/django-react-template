#!/usr/bin/env bash

# This script has been copied from
# https://github.com/nickjj/docker-django-example/blob/main/bin/rename-project

set -eo pipefail

APP_NAME="${1}"
MODULE_NAME="${2}"

FIND_APP_NAME="django_template"
FIND_MODULE_NAME="django_template"
FIND_FRAMEWORK="django"

if [ -z "${APP_NAME}" ] || [ -z "${MODULE_NAME}" ]; then
    echo "You must supply both an app and module name, example: ${0} myapp MyApp"
    exit 1
fi

if [ "${APP_NAME}" = "${FIND_APP_NAME}" ]; then
    echo "Your new app name must be different than the current app name"
    exit 1
fi

cat << EOF
When renaming your project you'll need to re-create a new database.

This can easily be done with Docker, but before this script does it
please agree that it's ok for this script to delete your current
project's database(s) by removing any associated Docker volumes.

EOF

while true; do
    read -p "Run docker compose down -v (y/n)? " -r yn
    case "${yn}" in
        [Yy]* )
          printf "\n--------------------------------------------------------\n"
          docker compose down -v
          printf -- "--------------------------------------------------------\n"

          break;;
        [Nn]* ) exit;;
        * ) echo "";;
    esac
done

# -----------------------------------------------------------------------------
# The core of the script which renames a few things.
# -----------------------------------------------------------------------------
find . -type f -exec \
  perl -i \
    -pe "s/(${FIND_APP_NAME}${FIND_FRAMEWORK}|${FIND_APP_NAME})/${APP_NAME}/g;" \
    -pe "s/${FIND_MODULE_NAME}/${MODULE_NAME}/g;" {} +
# -----------------------------------------------------------------------------

cat << EOF

--------------------------------------------------------
Your project has been renamed successfully!
--------------------------------------------------------

EOF

function init_git_repo {
  [ -d .git/ ] && rm -rf .git/

cat << EOF

--------------------------------------------------------
$(git init)
--------------------------------------------------------
EOF

  git symbolic-ref HEAD refs/heads/main
}

while true; do
    read -p "Do you want to init a new local git repo (y/n)? " -r yn
    case "${yn}" in
        [Yy]* ) init_git_repo; break;;
        [Nn]* ) break;;
        * ) echo "";;
    esac
done

cat << EOF

We're done here. Everything worked!

If you're happy with your new project's name you can delete this

EOF
