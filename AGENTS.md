# Homebrew Tap Notes

- Add an explicit `version` field on formula branches that use release asset filenames with architecture suffixes such as `arm64` or `x86_64`; omit it on source-tarball fallback branches where Homebrew can infer the version correctly.
- If a GitHub Actions workflow runs a repo-local path such as `scripts/...`, do it in a normal checked-out job. Do not rely on repo-local scripts from the Homebrew containerized `brew test-bot` job.
- Before pushing formula changes, run the local pre-commit hook or at minimum `brew style` and `brew audit --except=installed` on the changed formula.
