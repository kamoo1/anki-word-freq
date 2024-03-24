import os
import sys

__version__ = ""

sys.path.append(os.path.join(os.path.dirname(__file__), "vendors"))

from .awf import main

main()
