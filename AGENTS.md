# Homebrew Tap Notes

- Add an explicit `version` field when Homebrew release asset filenames include architecture suffixes such as `arm64` or `x86_64`; otherwise Homebrew can misparse the version, e.g. `arm64` -> `64`.
- Before pushing formula changes, run the local pre-commit hook or at minimum `brew style` and `brew audit --except=installed` on the changed formula.
