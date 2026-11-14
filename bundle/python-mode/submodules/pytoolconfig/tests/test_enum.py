from dataclasses import dataclass
from enum import Enum

from pytoolconfig.pytoolconfig import PyToolConfig


class Demo(Enum):
    DISABLED = False
    ENABLED = True
    ALT = "alternate"


@dataclass
class EnumModel:
    option1: Demo = Demo.DISABLED
    option2: Demo = Demo.DISABLED
    option3: Demo = Demo.DISABLED


def test_simple(cwd):
    config = PyToolConfig("pytoolconfig2", cwd, EnumModel)
    result = config.parse()
    assert result.option1 == Demo.DISABLED
    assert result.option2 == Demo.ENABLED
    assert result.option3 == Demo.ALT
