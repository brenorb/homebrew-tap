# Homebrew Tap Notes

- Do not add an explicit `version` field when Homebrew can infer the version from the release URL.
- Before pushing formula changes, run the local pre-commit hook or at minimum `brew style` and `brew audit --except=installed` on the changed formula.
