"""Exercise the real hook with a fake brew formatter and a temporary formula."""

import os
import subprocess
import sys
from pathlib import Path
from tempfile import TemporaryDirectory


def main() -> None:
    if len(sys.argv) != 2:
        raise SystemExit("Usage: check-style-gate.py <brew-style-formula.sh>")
    hook = Path(sys.argv[1]).resolve(strict=True)
    with TemporaryDirectory(prefix="tap-style-gate-") as scratch:
        root = Path(scratch)
        formula = root / "Formula" / "fixture.rb"
        formula.parent.mkdir()
        formula.write_text("# before formatting\n")
        brew = root / "brew"
        brew.write_text('#!/bin/sh\ntest "$1" = style && test "$2" = --fix || exit 2\n'
                        'printf "# formatted\\n" >> "$3"\n')
        brew.chmod(0o700)
        env = dict(os.environ, PATH=f"{root}{os.pathsep}{os.environ['PATH']}")
        result = subprocess.run(
            ["bash", str(hook), "Formula/fixture.rb"],
            cwd=root, env=env, text=True, capture_output=True, timeout=10,
        )
        assert formula.read_text().endswith("# formatted\n")
        assert result.returncode == 1, f"expected re-stage failure, got {result.returncode}"
        assert "re-stage" in result.stdout
        print("A changed formula requires review and re-staging.")


if __name__ == "__main__":
    main()
