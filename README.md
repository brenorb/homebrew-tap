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

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
