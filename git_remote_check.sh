function git_remote_check {
  local bgp_git_remote_status
  BGP_GIT_BRANCH=$(git branch --no-color 2> /dev/null | grep '*' | sed 's/\*//g' | sed 's/ //g')
  BGP_GIT_REMOTE=$(git config -l 2> /dev/null | grep "branch.*remote" | sed 's/branch.*remote=//g')
  bgp_git_remote_status=$(git remote show $BGP_GIT_REMOTE 2>&1)
  if [[ $bgp_git_remote_status == *Connection* ]]; then
    BGP_GIT_REMOTE_STATUS="\[\e[0;31m\](Connection problem)\[\e[0m\]"
  else
    BGP_GIT_REMOTE_STATUS=$(echo "$bgp_git_remote_status" | grep " $BGP_GIT_BRANCH " | grep "pushes to" | grep -o "(.*)")
  fi
  echo "BGP_GIT_BRANCH=$BGP_GIT_BRANCH" > $BGP_TMP_FILE
  echo "BGP_GIT_REMOTE=$BGP_GIT_REMOTE" >> $BGP_TMP_FILE
  echo "BGP_GIT_REMOTE_STATUS=\"$BGP_GIT_REMOTE_STATUS\"" >> $BGP_TMP_FILE
}
