#!/bin/sh

operand="$1"

case "$operand" in
  "-p"|"--pull")
    printf "Pulling drive now...\n"
    rclone sync -P ssh:drive "$HOME"/drive
    if [ "$?" ]; then
      printf "Drive sync complete\n"
    else
      printf "Error: Drive sync failed\n"
      exit 1
    fi ;;
  "-P"|"--push")
    printf "Pushing drive now...\n"
    rclone sync -P "$HOME"/drive ssh:drive
    if [ "$?" ]; then
      printf "Drive sync complete\n"
    else
      printf "Error: Drive sync failed\n"
      exit 1
    fi ;;
  "-h"|"--help")
    printf "Usage: drive-sync [-p/-P]\n"
    printf "  -p / --pull      Syncs remote drive to local computer, pulling changes\n"
    printf "  -P / --push      Syncs local computer to remote drive, pushing changes\n"
    printf "  -h / --help      Prints this help readout\n"
    exit 0 ;;
  *)
    printf "Error: Invalid operand. See drive-sync --help\n"
    exit 1 ;;
esac

exit 0
