#!/usr/bin/env python3
import json
import re
import sys
import urllib.request
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parents[1]
FORMULA_PATH = REPO_ROOT / "Formula" / "fast-transcript.rb"
PYPI_URL = "https://pypi.org/pypi/fscript/json"
GITHUB_RELEASE_URL = "https://api.github.com/repos/brenorb/fast-transcript/releases/tags/v{version}"


def fetch_json(url: str) -> dict:
    with urllib.request.urlopen(url, timeout=20) as response:
        return json.load(response)


def main() -> int:
    formula = FORMULA_PATH.read_text(encoding="utf-8")

    versions = sorted(set(re.findall(r"v(\d+\.\d+\.\d+)", formula)))
    if len(versions) != 1:
        raise SystemExit(f"expected exactly one fast-transcript version in formula, found {versions}")
    formula_version = versions[0]

    release_asset_urls = re.findall(
        r'https://github\.com/brenorb/fast-transcript/releases/download/v[^"]+/([^"]+)',
        formula,
    )
    if not release_asset_urls:
        raise SystemExit("expected release asset URLs in formula")

    if any(f"v{formula_version}" not in line for line in formula.splitlines() if "fast-transcript" in line and "url " in line):
        raise SystemExit("formula URLs do not consistently point at the same fast-transcript version")

    pypi_version = fetch_json(PYPI_URL)["info"]["version"]
    if pypi_version != formula_version:
        raise SystemExit(
            f"formula version {formula_version} does not match latest PyPI version {pypi_version}"
        )

    release = fetch_json(GITHUB_RELEASE_URL.format(version=formula_version))
    asset_names = {asset["name"] for asset in release.get("assets", [])}
    missing_assets = sorted(set(release_asset_urls) - asset_names)
    if missing_assets:
        raise SystemExit(
            "formula references release assets that do not exist: "
            + ", ".join(missing_assets)
        )

    print(
        f"fast-transcript formula is in sync with PyPI {pypi_version} "
        f"and GitHub release v{formula_version}"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
