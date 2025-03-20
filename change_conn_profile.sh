#!/bin/sh
# Switch between network manager connection profiles with dmenu

# list connection profiles
# TODO: make this work with connection profile names that contain spaces
list="$(nmcli -f NAME c show | awk 'NR>1 {print $1}')"

# profile selected via dmenu
choice="$(printf "%s" "${list}" | dmenu | xargs)"

# current active connection profile
active="$(nmcli -f NAME c show --active | tail -n +2 | xargs)"

# debug
#printf "List\n%s\n\n" "${list}"
#printf "Active\n%s\n\n" "${active}"
#printf "Choice\n%s\n" "${choice}"

# if the currently active profile gets selected, do nothing
if [ "${choice}" = "${active}" ]; then
  printf "You're already connected to %s\n" "${active}"
  exit 0
fi

# if the chosen profile exists within the profile list,
case "${list}" in
  *${choice}*)
    printf "Connecting to: %s\n" "${choice}"
    nmcli c up "${choice}"
    ;;
  *)
    printf "Profile %s not found" "${choice}"
    ;;
esac

