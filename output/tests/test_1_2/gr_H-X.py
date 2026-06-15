import numpy as np
import matplotlib.pyplot as txt

data = np.loadtxt('H0-X.txt')

H0 = data[:, 0]
X = data[:, 1]
H_theor = data[:, 2]
data = np.loadtxt('H1-X.txt')
H1 = data[:, 0]

txt.plot(X, H0, 'o',  markersize=1,  label='H without suction')
txt.plot(X, H_theor, 'o',  markersize=1,  label='H_theor without suction')
txt.plot(X, H1, 'o',  markersize=1,  label='H with suction')
txt.xlabel('X,m')
txt.ylabel('H,m')
txt.legend(loc='best', markerscale=3)
txt.minorticks_on()
txt.grid(which='major', linestyle='-', linewidth=0.7, alpha=0.7) 
txt.grid(which='minor', linestyle=':', linewidth=0.4, alpha=0.4) 
txt.savefig('H-X.png', dpi=300, bbox_inches='tight')
print('H was saved.')