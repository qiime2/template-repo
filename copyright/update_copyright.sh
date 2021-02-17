#!/bin/bash

. ../common/funcs.sh

set -e -x

# This script doesn't work with bare git repos. It also assumes the caller
# has push access to the remote repo.

if [ $# -eq 0 ] || [ $# -gt 2 ];
  then
    cat <<EOF
Usage: $0 \$LOCAL_REPO \$BRANCH

\$LOCAL_REPO      path to local repo
\$BRANCH          branch to work with
EOF
exit 0
fi

# args & vars
destination_repo=$1
local_branch=$2
commit_msg="MAINT: Updating copyright year"

# actions
validate_repo "$destination_repo"
prep_dest "$destination_repo" "$local_branch"
cd $destination_repo
q2lint --update-copyright-year
cd -
commit_changes "$destination_repo" "$commit_msg"
