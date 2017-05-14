#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

forkpoint="$(git merge-base --fork-point master)"
changed_files="$(git diff --name-only "$forkpoint")"

echo "Running tests for changed files:
$changed_files"

bundle exec rspec $changed_files
