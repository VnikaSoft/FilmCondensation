import numpy as np
import matplotlib.pyplot as txt

data = np.loadtxt('T-Y.txt')

y = data[:, 0]
T = data[:, 1]

x_line = [y[0], y[-1]]  
y_line = [T[0], T[-1]]  
txt.plot(x_line, y_line, 'r-', linewidth=0.3, label='T_theor')

txt.plot(y, T, 'o',  markersize=1,  label='T')

txt.xlabel('Y,m')
txt.ylabel('T,°C')
txt.legend(loc='best', markerscale=3)
txt.minorticks_on()  
txt.grid(which='major', linestyle='-', linewidth=0.7, alpha=0.7) 
txt.grid(which='minor', linestyle=':', linewidth=0.4, alpha=0.4)  
txt.savefig('T.png', dpi=300, bbox_inches='tight')
print('T was saved.')