function git_remote_check {
  BGP_GIT_BRANCH=$(git branch --no-color 2> /dev/null | grep '*' | sed 's/\*//g' | sed 's/ //g')
  export BGP_GIT_BRANCH
  BGP_GIT_REMOTE=$(git remote show 2> /dev/null | sed 's/ //g')
  export BGP_GIT_REMOTE
  if [ -z "$BGP_CR_COUNT" ]; then
    BGP_CR_COUNT="1"
    export BGP_CR_COUNT
  else
    BGP_CR_COUNT=$(($BGP_CR_COUNT + 1))
    export BGP_CR_COUNT
  fi
  if ((BGP_CR_COUNT > 10)); then
    BGP_GIT_REMOTE_STATUS=$(git remote show $BGP_GIT_REMOTE 2> /dev/null | grep " $BGP_GIT_BRANCH " | grep "pushes to" | grep -o "(.*)")
    export BGP_GIT_REMOTE_STATUS
    BGP_CR_COUNT="1"
    export BGP_CR_COUNT
  fi
}
