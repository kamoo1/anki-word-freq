import os
import sys

__version__ = "0.3.2"

sys.path.append(os.path.join(os.path.dirname(__file__), "vendors"))

from .awf import main

main()
