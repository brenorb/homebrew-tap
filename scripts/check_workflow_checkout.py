#!/usr/bin/env python3
from __future__ import annotations

import sys
from pathlib import Path


CHECKOUT_PATTERNS = (
    "uses: actions/checkout",
    "uses: actions/checkout@",
)

LOCAL_PATH_MARKERS = (
    " scripts/",
    "./scripts/",
    "scripts/",
)


def workflow_uses_local_scripts(text: str) -> bool:
    return any(marker in text for marker in LOCAL_PATH_MARKERS)


def workflow_has_checkout(text: str) -> bool:
    return any(pattern in text for pattern in CHECKOUT_PATTERNS)


def main(argv: list[str]) -> int:
    failures: list[str] = []
    for arg in argv[1:]:
        path = Path(arg)
        if not path.is_file():
            continue
        text = path.read_text(encoding="utf-8")
        if workflow_uses_local_scripts(text) and not workflow_has_checkout(text):
            failures.append(
                f"{path}: workflow references repo-local scripts but does not use actions/checkout"
            )

    if failures:
        print("\n".join(failures), file=sys.stderr)
        return 1

    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
