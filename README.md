# Wordlist Generator Script

This script generates a wordlist based on a provided URL. It processes the domain name, capitalizes subwords, and appends years and common patterns to create a list of potential usernames or passwords. The generated wordlist is saved to a file named `wordlist.txt`.

## Usage

To use the script, run the following command in your terminal:

```bash
./generate_wordlist.sh <url>
```

Replace `<url>` with the URL you want to generate the wordlist from.

## Example

```bash
./generate_wordlist.sh https://www.example.com
```

This will generate a wordlist based on the domain `example.com`.

## Script Details

The script performs the following steps:

1. **Removes Protocol and Path**: Strips the `http://` or `https://` and any path after the host.
2. **Removes **`www.`: Removes the `www.` prefix if present.
3. **Removes TLD**: Removes the top-level domain (TLD) (everything after the last dot).
4. **Splits Domain**: Splits the domain on dots (`.`) and processes each part.
5. **Capitalizes Subwords**: Capitalizes each subword and joins them together.
6. **Generates Combinations**: Appends years (from 2008 to the current year) and common patterns to create the wordlist.

## Output

The script outputs the generated base domain and saves the wordlist to a file named `wordlist.txt`.

## Example Output

```bash
Generated base domain: Example
Generating wordlist...
Wordlist saved to wordlist.txt
```

The `wordlist.txt` file will contain entries like:

```
Example
Example@2023
Example@2023*
UserExample
UserExample@2023
UserExample@2023*
```

## Requirements

- Bash shell
- `sed`, `cut`, `tr`, and `date` utilities (commonly available on Unix-like systems)

### fell free to modify anything
