---
name: verify-tap-release-gate
description: Model-check the Homebrew tap's formula style and fscript release checks when changing formatting, re-staging, version comparison, or release asset validation.
---

# Verify formula style and release checks

When the formatter changes a formula, the current hook run must fail so the maintainer can review and re-stage the file. Otherwise the hook can approve the earlier contents that are still staged.

Run with Java 11 or later and `TLA2TOOLS` set to the absolute path of the official [TLA+ 1.7.4 release JAR](https://github.com/tlaplus/tlaplus/releases/tag/v1.7.4).

```sh
sh scripts/check-cli-state-machine.sh .cursor/skills/verify-tap-release-gate/ReleaseGate.tla
```

## Coverage

Reviewed at `ad49866801d4da763a322e1df4e04fe2fc09afd3`.

| Model | Source |
| --- | --- |
| Require Homebrew, filter staged formula paths, and run the formatter. | `scripts/brew-style-formula.sh`, prerequisite, argument loop and `brew style --fix` |
| Compare hashes and fail if formatting changed any selected formula. | `brew-style-formula.sh`, `before_hashes` and `after_hashes` |
| For the fscript formula, check Python availability and run the release-sync command. | `brew-style-formula.sh`, final loop |
| Validate consistent formula versions and asset URLs, check PyPI, and check the GitHub release assets. | `scripts/check_fast_transcript_release_sync.py`, `main` and `fetch_json` |

The model bounds one invocation with no selected formula, a different formula, or the fscript formula. It summarizes the selected files by whether formatting changes any of them. The standalone release-sync command starts at the formula-version stage. Version and asset checks have symbolic success or failure outcomes. Hash collisions, changes by other processes, API payload parsing, and network latency are outside these bounds.

The baseline exhausted 21 states. The mutant passes after an edit. The local formatter fixture caught the same issue when the comparison block was removed in a scratch copy. The fixture passed again against the original script.

## Verify a change

1. Compare the scripts with the reviewed commit and update each affected guard or failure outcome.
2. Run the checker. Supply `.cursor/skills/verify-tap-release-gate/ReleaseGate-broken.cfg` as the second argument and confirm that it fails `StyleChangesRequireRestaging`. Inspect counterexamples using pstack's `/statechart`.
3. Run `python3 .cursor/skills/verify-tap-release-gate/references/check-style-gate.py scripts/brew-style-formula.sh`. In a disposable copy, remove the hash comparison block and confirm that the same fixture detects unexpected success.
4. Advance the reviewed commit after confirming the model matches the implementation.
