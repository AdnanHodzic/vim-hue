"""Setup pytest items."""
from __future__ import annotations

from pathlib import Path

import pytest


@pytest.fixture()
def cwd() -> Path:
    """Changes initial working directory for further tests.

    Returns:
    -------
        The directory with config files.

    """
    return Path(__file__).parent / "configfiles"
