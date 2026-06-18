# Brenorb Homebrew Tap

## How do I install these formulae?

```bash
brew tap brenorb/tap
brew install fast-transcript
```

Or, if you want the fully-qualified formula name:

```bash
brew install brenorb/tap/fast-transcript
```

If you previously used the old tap name, migrate with:

```bash
brew uninstall brenorb/fast-transcript/fast-transcript
brew untap brenorb/fast-transcript
brew tap brenorb/tap
brew install fast-transcript
```

Or, in a `brew bundle` `Brewfile`:

```ruby
tap "brenorb/tap"
brew "fast-transcript"
```

The formula uses prebuilt release binaries on:

- macOS arm64
- Linux x86_64

Other platforms fall back to a source build.

## Development

Install the local pre-commit hook before editing formulae:

```bash
python3 -m pip install pre-commit
pre-commit install
```

The hook runs `brew style --fix` on changed files under `Formula/` so Homebrew audit ordering issues are caught before push.

When `Formula/fast-transcript.rb` changes, the hook also runs `scripts/check_fast_transcript_release_sync.py` to ensure the formula's explicit `version` matches its release URLs, the latest `fscript` PyPI version, and the published upstream GitHub release assets.

Keep the explicit `version` in `Formula/fast-transcript.rb`. Homebrew misparses the version from release filenames like `fast-transcript-v1.1.2-macos-arm64.tar.gz` and will otherwise treat `arm64` as version `64`.

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
