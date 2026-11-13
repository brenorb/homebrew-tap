# Homebrew tap state machines

Reviewed `brenorb/homebrew-tap` main at `ad49866801d4da763a322e1df4e04fe2fc09afd3`. Freedom Skills refers to it as `brenorb/tap`. The tap distributes [BitChat](https://github.com/brenorb/bitchat-cli/blob/codex/cli-state-machines/docs/state-machines.md) and [fscript](https://github.com/brenorb/fast-transcript/blob/codex/cli-state-machines/docs/state-machines.md). The FluidAudio formula packages the external `FluidInference/FluidAudio` project. The tap defines no independent user CLI.

| Maintainer entrypoint | State and verification |
| --- | --- |
| `scripts/brew-style-formula.sh` | Filter staged formulas, format, compare hashes, require re-staging if the formatter changed content, and run the fscript release gate when selected. [Release gate](../.cursor/skills/verify-tap-release-gate/SKILL.md) |
| `scripts/check_fast_transcript_release_sync.py` | Compare formula versions, PyPI metadata and GitHub release assets, then return the combined verdict. [Release gate](../.cursor/skills/verify-tap-release-gate/SKILL.md) |
| `scripts/check_workflow_checkout.py` | Accumulate workflow job evidence and check that scripts can access the checkout. The current scanner accepts a local script placed before checkout. [Workflow checkout](../.cursor/skills/verify-tap-workflow-checkout/SKILL.md) |

The pre-commit configuration invokes the formatter and workflow scanner for matching files. The main and pull-request test workflow invokes the release-sync command, and delegates formula and bottle tests to Homebrew. The labeled pull-request workflow delegates bottle pulling and branch updates to Homebrew, then deletes the branch only for a same-repository pull request. The formulae declare sources, dependencies and installed executables. The models use fixture results for Homebrew and registry responses.
