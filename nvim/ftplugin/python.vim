" set some python abbreviations

" shabang
call Iab('#!', '#!/usr/bin/env python')

" main
call Iab('pymain', 'if __name__ == "__main__":<Enter>main()')

" import sets
call Iab('imgimp', 'import numpy as np<Enter>from PIL import Image<Enter>')
call Iab('dsimp', 'import numpy as np<Enter>import pandas as pd<Enter>import matplotlib as mpl<Enter>import matplotlib.pyplot as plt<Enter>')
