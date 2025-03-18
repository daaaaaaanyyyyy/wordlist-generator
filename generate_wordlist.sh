#!/bin/bash

# Usage: ./generate_wordlist.sh <url>
if [ $# -eq 0 ]; then
    echo "Usage: $0 <url>"
    exit 1
fi

url="$1"

# 1. Remove protocol (http:// or https://) and any path after the host.
domain=$(echo "$url" | sed -e 's|^[^/]*//||' -e 's|/.*$||')

# 2. Remove www. if present.
domain=$(echo "$domain" | sed 's/^www\.//')

# 3. Remove the TLD (everything after the last dot).
domain_no_tld=$(echo "$domain" | rev | cut -d'.' -f2- | rev)

# 4. Split the domain on dots (.) and process each part.
IFS='.' read -ra domain_parts <<< "$domain_no_tld"

final_domain=""

# 5. Capitalize each subword and join them together.
for part in "${domain_parts[@]}"; do
    IFS='-' read -ra subparts <<< "$part"
    for sub in "${subparts[@]}"; do
        first=$(echo "${sub:0:1}" | tr '[:lower:]' '[:upper:]')
        rest=$(echo "${sub:1}" | tr '[:upper:]' '[:lower:]')
        final_domain+="${first}${rest}"
    done
done

echo "Generated base domain: $final_domain"
echo "Generating wordlist..."

wordlist_file="wordlist.txt"
> "$wordlist_file"  # Clear the file before writing.

# 6. Generate combinations.
start_year=2008
current_year=$(date +%Y)

for year in $(seq $start_year $current_year); do
    echo "$final_domain" >> "$wordlist_file"
    echo "${final_domain}@${year}" >> "$wordlist_file"
    echo "${final_domain}@${year}*" >> "$wordlist_file"

    echo "User${final_domain}" >> "$wordlist_file"
    echo "User${final_domain}@${year}" >> "$wordlist_file"
    echo "User${final_domain}@${year}*" >> "$wordlist_file"
done

echo "Wordlist saved to $wordlist_file"
