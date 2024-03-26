import os
import sys

__version__ = "0.1.3"

sys.path.append(os.path.join(os.path.dirname(__file__), "vendors"))

from .awf import main

main()
