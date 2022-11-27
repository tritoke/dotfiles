" always retab a python file to four spaces
auto BufWritePre *.py retab 4

" set some python abbreviations

" shabang
call sab#Iab('#!', '#!/usr/bin/env python')

" main
call sab#Iab('pymain', 'if __name__ == "__main__":<Enter>main()')

" import sets
call sab#Iab('imgimp', 'import numpy as np<Enter>from PIL import Image<Enter>')
call sab#Iab('dsimp', 'import numpy as np<Enter>import pandas as pd<Enter>import matplotlib as mpl<Enter>import matplotlib.pyplot as plt<Enter>')
