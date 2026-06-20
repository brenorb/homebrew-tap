# Homebrew Tap Notes

- Add an explicit `version` field when Homebrew release asset filenames include architecture suffixes such as `arm64` or `x86_64`; otherwise Homebrew can misparse the version, e.g. `arm64` -> `64`.
- If a GitHub Actions workflow runs a repo-local path such as `scripts/...`, do it in a normal checked-out job. Do not rely on repo-local scripts from the Homebrew containerized `brew test-bot` job.
- Before pushing formula changes, run the local pre-commit hook or at minimum `brew style` and `brew audit --except=installed` on the changed formula.
