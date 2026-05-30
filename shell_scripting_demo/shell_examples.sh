#!/usr/bin/env bash
#
# shell_examples.sh
#
# A cleaner Bash showcase split into small mini-demos:
# - basics and variables
# - arguments and validation
# - conditionals
# - loops
# - arrays
# - functions
# - file handling
# - command substitution and text processing
# - traps and cleanup
#
# Usage:
#   chmod +x shell_examples.sh
#   ./shell_examples.sh
#   ./shell_examples.sh --name "Alice" --count 3 --verbose
#   ./shell_examples.sh --help

set -Eeuo pipefail
IFS=$'\n\t'

readonly SCRIPT_NAME="$(basename "$0")"
readonly VERSION="1.1.0"

NAME="World"
COUNT=3
VERBOSE=false

TEMP_DIR=""

timestamp() {
  date '+%Y-%m-%d %H:%M:%S'
}

log_info() {
  echo "[$(timestamp)] [INFO]  $*"
}

log_warn() {
  echo "[$(timestamp)] [WARN]  $*" >&2
}

log_error() {
  echo "[$(timestamp)] [ERROR] $*" >&2
}

log_debug() {
  if [[ "$VERBOSE" == true ]]; then
    echo "[$(timestamp)] [DEBUG] $*"
  fi
}

usage() {
  cat <<EOF
$SCRIPT_NAME v$VERSION

Bash shell scripting examples split into mini-demos.

Usage:
  $SCRIPT_NAME [options]

Options:
  --name NAME       Name used in greetings (default: World)
  --count N         Number of loop iterations (default: 3)
  --verbose         Enable debug logging
  --help            Show this help message

Examples:
  $SCRIPT_NAME
  $SCRIPT_NAME --name "Alice"
  $SCRIPT_NAME --name "Bob" --count 5 --verbose
EOF
}

cleanup() {
  if [[ -n "${TEMP_DIR:-}" && -d "$TEMP_DIR" ]]; then
    rm -rf "$TEMP_DIR"
    log_debug "Removed temporary directory: $TEMP_DIR"
  fi
}

on_error() {
  local exit_code=$?
  log_error "Failed at line $1 with exit code $exit_code"
  exit "$exit_code"
}

parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --name)
        [[ $# -ge 2 ]] || { log_error "--name requires a value"; exit 1; }
        NAME="$2"
        shift 2
        ;;
      --count)
        [[ $# -ge 2 ]] || { log_error "--count requires a value"; exit 1; }
        COUNT="$2"
        shift 2
        ;;
      --verbose)
        VERBOSE=true
        shift
        ;;
      --help|-h)
        usage
        exit 0
        ;;
      *)
        log_error "Unknown option: $1"
        usage
        exit 1
        ;;
    esac
  done
}

demo_basics() {
  log_info "Demo 1: basics"

  local language="Bash"
  local greeting="Hello"
  local target="$NAME"
  local year=2026

  echo "Language: $language"
  echo "Greeting: $greeting"
  echo "Target: $target"
  echo "Year: $year"
  echo "${greeting}, ${target}!"
}

demo_validation() {
  log_info "Demo 2: validation"

  if [[ "$COUNT" =~ ^[0-9]+$ ]]; then
    echo "COUNT is numeric: $COUNT"
  else
    log_error "COUNT must be a number"
    exit 1
  fi

  if [[ "$COUNT" -eq 0 ]]; then
    log_warn "COUNT is zero, loops will not run"
  elif [[ "$COUNT" -lt 0 ]]; then
    log_error "COUNT must not be negative"
    exit 1
  else
    echo "COUNT looks good: $COUNT"
  fi
}

demo_conditionals() {
  log_info "Demo 3: conditionals"

  local number=10
  local threshold=5

  if [[ "$number" -gt "$threshold" ]]; then
    echo "$number is greater than $threshold"
  else
    echo "$number is not greater than $threshold"
  fi

  local os_name="$(uname -s)"
  case "$os_name" in
    Linux)
      echo "Running on Linux"
      ;;
    Darwin)
      echo "Running on macOS"
      ;;
    *)
      echo "Running on: $os_name"
      ;;
  esac
}

demo_loops() {
  log_info "Demo 4: loops"

  echo "For loop over words:"
  for word in alpha beta gamma; do
    echo "  word=$word"
  done

  echo "Numeric loop:"
  for ((i = 1; i <= COUNT; i++)); do
    echo "  iteration=$i"
  done

  echo "While loop countdown:"
  local n=3
  while [[ "$n" -gt 0 ]]; do
    echo "  countdown=$n"
    ((n--))
  done
}

demo_arrays() {
  log_info "Demo 5: arrays"

  local fruits=("apple" "banana" "mango" "orange")

  echo "Array size: ${#fruits[@]}"
  echo "First item: ${fruits[0]}"
  echo "All items: ${fruits[*]}"

  echo "Iterating with indices:"
  for i in "${!fruits[@]}"; do
    echo "  [$i]=${fruits[$i]}"
  done
}

add_numbers() {
  local a="$1"
  local b="$2"
  echo $((a + b))
}

greet_person() {
  local person_name="${1:-Guest}"
  echo "Welcome, $person_name"
}

demo_functions() {
  log_info "Demo 6: functions"

  local sum
  sum="$(add_numbers 7 8)"
  echo "7 + 8 = $sum"

  greet_person "$NAME"
  greet_person
}

demo_files() {
  log_info "Demo 7: files"

  TEMP_DIR="$(mktemp -d)"
  local sample_file="$TEMP_DIR/sample.txt"

  {
    echo "This is a sample file."
    echo "Created by shell_examples.sh"
  } > "$sample_file"

  echo "Created: $sample_file"

  if [[ -f "$sample_file" ]]; then
    echo "File exists"
    echo "Contents:"
    cat "$sample_file"
  fi

  echo "Line count: $(wc -l < "$sample_file")"

  echo "Appending another line..."
  echo "A second line for the demo." >> "$sample_file"
  cat "$sample_file"
}

demo_command_substitution() {
  log_info "Demo 8: command substitution"

  local current_dir
  current_dir="$(pwd)"

  local current_user
  current_user="$(whoami)"

  echo "Current directory: $current_dir"
  echo "Current user: $current_user"
  echo "Current date: $(date)"
}

demo_text_processing() {
  log_info "Demo 9: text processing"

  local text="Bash scripting is powerful"

  echo "Original: $text"
  echo "Uppercase: ${text^^}"
  echo "Lowercase: ${text,,}"
  echo "Replace: ${text/scripting/automation}"

  printf '%s\n' "alpha" "beta" "gamma" | while IFS= read -r line; do
    echo "  line=$line"
  done
}

demo_exit_codes() {
  log_info "Demo 10: exit codes"

  if ls /tmp >/dev/null 2>&1; then
    echo "ls /tmp succeeded"
  else
    echo "ls /tmp failed"
  fi

  false || echo "The false command returned a non-zero exit code, as expected"
}

demo_summary() {
  log_info "Demo 11: summary"

  cat <<EOF
This script demonstrates:
- strict mode
- argument parsing
- logging
- traps and cleanup
- variables
- conditionals
- loops
- arrays
- functions
- files
- command substitution
- text processing
- exit codes
EOF
}

main() {
  trap cleanup EXIT
  trap 'on_error $LINENO' ERR

  parse_args "$@"

  log_info "Starting demo for '$NAME'"

  demo_basics
  demo_validation
  demo_conditionals
  demo_loops
  demo_arrays
  demo_functions
  demo_files
  demo_command_substitution
  demo_text_processing
  demo_exit_codes
  demo_summary

  log_info "Completed successfully"
}

main "$@"
