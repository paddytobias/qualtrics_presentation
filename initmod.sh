#!/usr/bin/env bash

# ------------------------------------------------------------------------------
#
# Program: initmod.sh
# Adapted from :  https://github.com/thiagorossener/jekflix-template
# Description: script to create an initial structure for a module.
#
# Usage: ./initmod.sh [options] <module number> <module name (with spaces)>
#
# Options:
#   -h, --help        output instructions
#   -c, --create      create post
#
# Alias: alias newpost="bash ~/path/to/script/initmod.sh"
#
# Example:
#   ./initmod.sh -c 8 next-steps
#
# Important Notes:
#   - This script was created to generate new markdown files for Intersect training modules.
#
# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# | VARIABLES                                                                  |
# ------------------------------------------------------------------------------

# CORE: Do not change these lines
# ----------------------------------------------------------------
POST_TITLE="${@:3:$(($#-1))}"
MOD_NAME="$(echo ${@:3:$(($#-1))} | sed -e 's/ /-/g' | sed "y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/" | sed -e 's/[\?\.\!\%\$\@\+]//')"
MOD_NUMBER="$(echo ${@:2:1})"
CURRENT_DATE="$(date -u +'%Y-%m-%d')"
TIME=$(date -u +"%T")
FILE_NAME="${MOD_NUMBER}-${MOD_NAME}.md"
# ----------------------------------------------------------------


# SETTINGS: your configuration goes here
# ----------------------------------------------------------------

# Set your destination folder
BINPATH=$(cd `dirname $0`; pwd)
POSTPATH="${BINPATH}/docs/modules"
DIST_FOLDER="$POSTPATH"

# Set your blog URL
#BLOG_URL=""

# Set your assets URL
#ASSETS_URL="assets/img/"
# ----------------------------------------------------------------



# ------------------------------------------------------------------------------
# | UTILS                                                                      |
# ------------------------------------------------------------------------------

# Header logging
e_header() {
    printf "$(tput setaf 4)→ %s$(tput sgr0)\n" "$@"
}

# Success logging
e_success() {
    printf "$(tput setaf 9)✔ %s$(tput sgr0)\n" "$@"
}

# File path
e_filepath() {
    printf "$(tput setaf 22)✔ %s$(tput sgr0)\n" "$@"
}


# Error logging
e_error() {
    printf "$(tput setaf 1)✖ %s$(tput sgr0)\n" "$@"
}

# Warning logging
e_warning() {
    printf "$(tput setaf 3)! %s$(tput sgr0)\n" "$@"
}



# ------------------------------------------------------------------------------
# | MAIN FUNCTIONS                                                             |
# ------------------------------------------------------------------------------

# Everybody need some help
initmod_help() {

cat <<EOT
------------------------------------------------------------------------------
INIT POST - A shortcut to create an initial structure for my posts.
------------------------------------------------------------------------------
Usage: ./initmod.sh [options] <module number> <module name (with spaces)>
Options:
  -h, --help        output instructions
  -c, --create      create module
Example:
  ./initmod.sh -c 01 This is a new module
Important Notes:
  - This script was created to generate new module templates for the Intersect course.

------------------------------------------------------------------------------
EOT

}

# Initial Content
initmod_content() {

echo "---"
echo "layout: page"
echo "title: \"${POST_TITLE}\""
echo "date: ${CURRENT_DATE} ${TIME}"
echo "short-title: \"Mod. ${MOD_NUMBER}\""
echo "show-in-nav-bar: true"
echo "teaching: 15"
echo "exercises: 5"
echo "questions: #add module questions"
echo "objectives: #add module objectives"
echo "keypoints: #add module key points"
echo "---"
echo ""
echo ">Objectives"
echo ">- Objective 1"
echo ">- Objective 2"
echo ">- Objective 3"
echo "{: .objective}"
echo ""
echo ""
echo ""
echo "## Next"
echo "[Go to Module $((${MOD_NUMBER}+1))]({{ site.baseurl }}/modules/$((${MOD_NUMBER}+1))-[**INSERT MODULE $((${MOD_NUMBER}+1)) FILENAME**]){: .next-link}"

}

# Create file
initmod_file() {
    if [ ! -f "$FILE_NAME" ]; then
        e_header "Creating template..."
        initmod_content > "${DIST_FOLDER}/${FILE_NAME}"
        e_success "Initial module successfully created!"
        e_filepath "Module found at docs/modules/${FILE_NAME}"
    else
        e_warning "File already exist."
        exit 1
    fi

}



# ------------------------------------------------------------------------------
# | INITIALIZE PROGRAM                                                         |
# ------------------------------------------------------------------------------

main() {

    # Show help
    if [[ "${1}" == "-h" || "${1}" == "--help" ]]; then
        initmod_help ${1}
        exit
    fi

    # Create
    if [[ "${1}" == "-c" || "${1}" == "--create" ]]; then
        initmod_file $*
        exit
    fi

}

# Initialize
main $*
