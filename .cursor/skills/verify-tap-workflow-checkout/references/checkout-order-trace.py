"""Replay the order-sensitive workflow with the actual line-based checker."""

import subprocess
import sys
from pathlib import Path
from tempfile import TemporaryDirectory

HEADER = "jobs:\n  verify:\n    runs-on: ubuntu-latest\n    steps:\n"
LOCAL_SCRIPT = "      - run: python3 scripts/example.py\n"
CHECKOUT = "      - uses: actions/checkout@v5\n"


def main() -> None:
    checker = Path("scripts/check_workflow_checkout.py").resolve(strict=True)
    with TemporaryDirectory(prefix="tap-checkout-trace-") as scratch:
        workflow = Path(scratch) / "workflow.yml"
        for steps, expected in (
            (CHECKOUT + LOCAL_SCRIPT, 0),
            (LOCAL_SCRIPT, 1),
            (LOCAL_SCRIPT + CHECKOUT, 0),
        ):
            workflow.write_text(HEADER + steps)
            result = subprocess.run(
                [sys.executable, str(checker), str(workflow)],
                text=True, capture_output=True, timeout=10,
            )
            assert result.returncode == expected, result
        print("The checker accepts a local script before the checkout step.")


if __name__ == "__main__":
    main()
