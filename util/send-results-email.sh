# Now send results by github

# TODO not finished

# VERSION_DIR=$1
# VERSION_NAME=$2
# BRANCH_NAME="experiment-reports"

# git show-ref --verify refs/heads/$BRANCH_NAME
# if [ $? != 0 ]; then
#   git branch $BRANCH_NAME
# fi

# git checkout $BRANCH_NAME

# # Just in case the branch already exists and someone updates it
# git pull origin $BRANCH_NAME

# git add $VERSION_DIR
# git commit -m "Experiment report $VERSION_NAME"
# git push origin $BRANCH_NAME

# # Get back to the last branch
# git checkout @{-1}