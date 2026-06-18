#!/usr/bin/env bash
set -euo pipefail

if ! command -v brew >/dev/null 2>&1
then
  echo "brew is required to style formulae. Install Homebrew or skip this hook explicitly."
  exit 1
fi

formula_files=()
for file in "$@"
do
  if [[ "${file}" == Formula/*.rb && -f "${file}" ]]
  then
    formula_files+=("${file}")
  fi
done

if [[ ${#formula_files[@]} -eq 0 ]]
then
  exit 0
fi

before_hashes="$(shasum "${formula_files[@]}")"
brew style --fix "${formula_files[@]}"
after_hashes="$(shasum "${formula_files[@]}")"

if [[ "${before_hashes}" != "${after_hashes}" ]]
then
  echo "Homebrew style auto-corrected formulae. Review the changes and re-stage them."
  exit 1
fi

for file in "${formula_files[@]}"
do
  if [[ "${file}" == "Formula/fast-transcript.rb" ]]
  then
    if ! command -v python3 >/dev/null 2>&1
    then
      echo "python3 is required to validate ${file}. Install Python or skip this hook explicitly."
      exit 1
    fi

    python3 scripts/check_fast_transcript_release_sync.py
  fi
done
