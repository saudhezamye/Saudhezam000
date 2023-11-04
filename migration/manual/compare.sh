#!/bin/bash
file="username.txt"

users_array=()
while IFS= read -r -d '' file; do
    users_array+=("${file##*/}")
done < <(find /var/cpanel/users -maxdepth 1 -type f -print0)
output_array=()
while IFS= read -r line; do
    output_array+=("$line")
done < "$file"
missing_entries=()
for entry in "${output_array[@]}"; do
    if [[ ! " ${users_array[*]} " =~ " $entry " ]]; then
        missing_entries+=("$entry")
    fi
done
for entry in "${missing_entries[@]}"; do
    echo "$entry"
done
