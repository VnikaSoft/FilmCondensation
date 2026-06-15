import numpy as np
import matplotlib.pyplot as txt

data = np.loadtxt('U-Y.txt')

y = data[:, 0]
U = data[:, 1]
U_theor = data[:, 2]

txt.plot(y, U, 'o',  markersize=1,  label='U')
txt.plot(y, U_theor, '-',  markersize=1,  label='U_theor')
txt.xlabel('Y,m')
txt.ylabel('U,m/s')
txt.legend(loc='best', markerscale=3)

txt.minorticks_on()  
txt.grid(which='major', linestyle='-', linewidth=0.7, alpha=0.7)  
txt.grid(which='minor', linestyle=':', linewidth=0.4, alpha=0.4)  
txt.savefig('U-Y.png', dpi=300, bbox_inches='tight')

print('U-Y was saved.')