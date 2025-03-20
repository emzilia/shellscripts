#!/bin/sh

# Shared, configurable global variables
drivepath="$HOME/drive"
configpath="$HOME/driveconfig/"
pass="file:secret.key"
cypher="aes-256-cbc"

# Creates tar archives of all folders within the drive folder
create_archives() {
  cd "$drivepath"
  for file in *; do
    tar -cvf all_drive_"$file".tar "$file" >/dev/null 2>&1
    if [ "$?" ]; then
      printf "%s archive creation successful\n" "$file"
    else
      printf "%s archive creation failure, skipping\n" "$file"
    fi
  done
  mv drive_* "$configpath"
}

# Encrypts all of the tar archives, creating them if they're missing
encrypt_archives() {
  mkdir -p "$drivepath" 
  mkdir -p "$configpath"

  if [ ! -f secret.key ]; then
    while [ "$response" != "y" ] && [ "$response" != "n" ]; do
      printf "Error: No encryption key found. Generate a new one now? y/n\n"
      read -n 1 response
    done
    if [ "$response" == "y" ]; then
      generate_key
    else
      exit 1
    fi
  fi

  cd "$configpath"
  if [ ! -f drive_Documents.tar ]; then
    printf "Drive archive missing, creating now...\n"
    create_archives
    printf "Archive creation complete\n"
  fi

  cd "$configpath"
  printf "Found archives, beginning encryption...\n"
  for file in "$configpath"/*.tar; do
    openssl "$cypher" -e -v -pbkdf2 -pass "$pass" -in "$file" -out "$file".enc
    if [ -f "$file".enc ]; then
      printf "%s encryption successful\n" "$file"
      rm "$file"
    else
      printf "Error encrypting %s\n" "$file"
      rm "$file"
    fi
  done
}

# Decrypts all of the tar archives into the drive dir. Assumes you have all of the
# archives in one folder along with the encryption key.
decrypt_archives() {
  mkdir -p "$drivepath" 
  mkdir -p "$configpath"

  if [ -f drive_Documents.tar ]; then
    printf "Archives located, moving files and beginning decryption...\n"
  else
    printf "Error: Unable to locate encrypted archives\n"
    exit 1
  fi

  if [ ! -f secret.key ]; then
    printf "Error: Unable to locate encryption key\n"
    exit 1
  fi

  for file in drive_*; do
    original_file="${file%.enc}"
    printf "Uploading: /%s" "$file"
    mv "$file" "$drivepath"
    openssl $cypher -d -v -pbkdf2 -pass $pass -in "$drivepath"/"$file" -out "$drivepath"/"$original_file"
    tar -xf "$drivepath"/"$original_file" -C "$drivepath"
  done
}

# Uploads all of the encrypted tar archives to MEGA, env variables are used to login
upload_mega() {
  cd "$configpath"
  mega-login "$MEGA_EMAIL" "$MEGA_PW"
  for file in drive_*; do
    printf "Uploading: /%s" "$file"
    mega-put "$configpath"/"$file"
    if [ "$?" ]; then
      rm "$file"
    fi
  done
  mega-logout
  exit
}

# Generates a new key to encrypt the archives with
generate_key() {
  local length="32"
  dir="$(pwd)"

  if [ -f secret.key ]; then
    while [ "$response" != "y" ] && [ "$response" != "n" ]; do
      printf "This directory already contains an encryption key. Generate a new one now? y/n\n"
      read -n 1 response
    done
    if [ "$response" == "y" ]; then
      continue
    else
      exit 1
    fi
  fi

  openssl rand -out secret.key "$length"
  if [ "$?" ]; then
    printf "Encryption key created at: %s/secret.key\n" "$dir"
  else
    printf "Error: Encryption key creation failure\n"
    exit 1
  fi
}

print_help() {
  printf "Usage: drive-backup [operand]\n"
  printf "  -e\tEncrypts files within the drive folder and uploads them\n"
  printf "  -d\tDecrypts files and extracts them into the drive folder\n"
  printf "  -g\tGenerates a new encryption key\n"
}

main() {
  option="$1"
  case "$option" in
    "-d")
      decrypt_archives ;;
    "-g")
      generate_key ;;
    "-e")
      encrypt_archives
      upload_mega ;;
    *)
      print_help ;;
  esac
}

main "$@"
exit 0
