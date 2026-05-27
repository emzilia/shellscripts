#!/bin/sh -e

path="/usr/lib/jvm/"
versions=()

if [ $1 == "check" ]; then
  printf "Current JAVA_HOME=%s\n" $JAVA_HOME
  exit 1
fi

printf "Current JAVA_HOME=%s\n" $JAVA_HOME
printf "Select a version:\n"

for dir in /usr/lib/jvm/*/; do
  dir_base=$(basename $dir)
  if [ "$dir_base" != "default" ] && [ "$dir_base" != "default-runtime" ]; then
    versions+=($dir_base)
  fi
done

i=0
for ver in ${versions[@]}; do
  i=$(($i + 1))
  printf "%d. %s\n" $i $ver
done  

response=0
read -s -n 1 response
if [ "$response" -lt 1 ] || [ "$response" -gt $((${#versions[*]} + 1)) ]; then
  printf "\nError: Invalid version\n"
  exit 1
fi

set_version=${versions[$(($response - 1))]}
combined="$path""$set_version"
export JAVA_HOME=$combined
printf "Completed: export JAVA_HOME=%s\n" $combined
