import numpy as np
import matplotlib.pyplot as txt

data = np.loadtxt('TAU-X.txt')

H = data[:, 0]
X = data[:, 1]
H_th = data[:, 2]

txt.plot(X, H, 'o',  markersize=1,  label='TAU')
txt.plot(X, H_th, '-',  markersize=1,  label='TAU_theor')
txt.xlabel('X,m')
txt.ylabel('TAU,Pa')
txt.legend(loc='best', markerscale=3)
txt.minorticks_on()  
txt.grid(which='major', linestyle='-', linewidth=0.7, alpha=0.7)  
txt.grid(which='minor', linestyle=':', linewidth=0.4, alpha=0.4)  
txt.savefig('TAU-X.png', dpi=300, bbox_inches='tight')
print('TAU was saved.')