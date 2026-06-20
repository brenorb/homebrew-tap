#!/usr/bin/env python3
from __future__ import annotations

import sys
from pathlib import Path


CHECKOUT_PATTERNS = ("uses: actions/checkout", "uses: actions/checkout@")
LOCAL_PATH_MARKERS = (" scripts/", "./scripts/", "scripts/")


def is_job_header(line: str) -> bool:
    return line.startswith("  ") and not line.startswith("    ") and line.rstrip().endswith(":")


def main(argv: list[str]) -> int:
    failures: list[str] = []
    for arg in argv[1:]:
        path = Path(arg)
        if not path.is_file():
            continue
        current_job: str | None = None
        job_has_container = False
        job_has_checkout = False
        job_uses_local_script = False

        def finalize_job() -> None:
            if current_job is None or not job_uses_local_script:
                return
            if job_has_container:
                failures.append(
                    f"{path}: job {current_job} references repo-local scripts inside a containerized job; move that script to a normal checked-out job"
                )
            elif not job_has_checkout:
                failures.append(
                    f"{path}: job {current_job} references repo-local scripts but does not use actions/checkout"
                )

        for raw_line in path.read_text(encoding="utf-8").splitlines():
            if is_job_header(raw_line):
                finalize_job()
                current_job = raw_line.strip().removesuffix(":")
                job_has_container = False
                job_has_checkout = False
                job_uses_local_script = False
                continue

            if current_job is None:
                continue
            if raw_line.startswith("    container:"):
                job_has_container = True
            if any(pattern in raw_line for pattern in CHECKOUT_PATTERNS):
                job_has_checkout = True
            if any(marker in raw_line for marker in LOCAL_PATH_MARKERS):
                job_uses_local_script = True

        finalize_job()

    if failures:
        print("\n".join(failures), file=sys.stderr)
        return 1

    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
