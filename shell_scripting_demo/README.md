# Shell Scripting Examples

This repository contains a clean Bash script that demonstrates common shell scripting patterns in a small, readable format.

## Files

- `shell_examples.sh` — the main demo script
- `README.md` — quick usage and notes

## What the script demonstrates

- strict mode with `set -Eeuo pipefail`
- argument parsing with `--name`, `--count`, and `--verbose`
- logging helpers
- traps and cleanup
- variables and constants
- conditionals
- loops
- arrays
- functions
- file handling
- command substitution
- text processing
- exit codes

## Requirements

- Bash 4+ recommended
- Standard Unix tools such as `date`, `cat`, `wc`, `ls`, `mktemp`, and `uname`

## Usage

```bash
chmod +x shell_examples.sh
./shell_examples.sh
./shell_examples.sh --name "Alice"
./shell_examples.sh --name "Bob" --count 5 --verbose
./shell_examples.sh --help
```

## Suggested repo layout

```text
shell-scripting-demo/
├── README.md
└── shell_examples.sh
```

## Notes

The script is intentionally split into small functions so each mini-demo can be read, copied, or reused independently.
If you are using this as a training sample, you can easily add more demos such as:
- string handling
- reading user input
- working with command-line pipelines
- creating temporary backups
- parsing CSV or log files

## License

Use this however you like in your own internal SCM repository.
