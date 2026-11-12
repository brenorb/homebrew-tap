---
name: verify-tap-workflow-checkout
description: Model-check the Homebrew tap's workflow checkout checker when changing job parsing or requirements for scripts run by GitHub Actions.
---

# Verify checkout order for local workflow scripts

An approved workflow should check out the repository before running a repository-local script. A checkout later in the job cannot supply files to an earlier step.

Run with Java 11 or later and `TLA2TOOLS` set to the absolute path of the official [TLA+ 1.7.4 release JAR](https://github.com/tlaplus/tlaplus/releases/tag/v1.7.4).

```sh
sh scripts/check-cli-state-machine.sh .cursor/skills/verify-tap-workflow-checkout/WorkflowCheckout.tla
```

## Coverage

Reviewed at `ad49866801d4da763a322e1df4e04fe2fc09afd3`.

| Model | Source |
| --- | --- |
| A header finalizes the previous job and resets its flags. | `scripts/check_workflow_checkout.py`, `is_job_header` and the scan loop in `main` |
| A line can set container, checkout or local script flags. | `main`, `CHECKOUT_PATTERNS` and `LOCAL_PATH_MARKERS` |
| End of file finalizes the last job, and the script exits with the aggregated verdict. | `main`, `finalize_job` and the exit branch |

The model bounds one recognized workflow file and up to two jobs, with one occurrence of each relevant line per job. It assumes correctly recognized job headers and models the order of line events. YAML recognition, actual Actions execution, and the filesystem after checkout are outside these bounds.

## Known finding

`ApprovedScriptsFollowCheckout` fails. The current script records that a job contains a checkout and that it contains a local script. When the local script comes first, the checker still accepts the job at the end of the file. pstack's `/statechart` reached 78 states, found the four-step path, and checked `NoDeadlock`.

Replay using the real checker and temporary workflow fixtures.

```sh
python3 .cursor/skills/verify-tap-workflow-checkout/references/checkout-order-trace.py
```

The checker accepts the correctly ordered workflow, rejects the workflow with no checkout, and accepts the workflow that checks out after invoking the local script.

## Verify a change

1. Compare the scan loop and job finalization against the reviewed commit, including when flags are reset and how failures accumulate.
2. Run the checker and interpret changed traces with pstack's `/statechart`. Replay the fixture. When a fix is intentional, the workflow with the late checkout must return an error.
3. Advance the reviewed commit once the model matches the code.
