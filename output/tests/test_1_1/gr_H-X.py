import numpy as np
import matplotlib.pyplot as txt
data = np.loadtxt('H-X.txt')

H = data[:, 0]
X = data[:, 1]
H_th = data[:, 2]

data = np.loadtxt('H2-X.txt')
H2 = data[:, 0]
X2 = data[:, 1]

data = np.loadtxt('H3-X.txt')
H3 = data[:, 0]
X3 = data[:, 1]

data = np.loadtxt('H4-X.txt')
H4 = data[:, 0]
X4 = data[:, 1]

txt.plot(X, H, 'o',  markersize=1,  label='H')
txt.plot(X2, H2, 'o',  markersize=1,  label="Н/2")
txt.plot(X3, H3, 'o',  markersize=1,  label="Н/3")
txt.plot(X4, H4, 'o',  markersize=1,  label="Н/4")
txt.plot(X, H_th, '-',  markersize=1,  label='H_theor')
txt.xlabel('X,m')
txt.ylabel('H,m')

txt.legend(loc='best', markerscale=3)

txt.minorticks_on() 
txt.grid(which='major', linestyle='-', linewidth=0.7, alpha=0.7)  
txt.grid(which='minor', linestyle=':', linewidth=0.4, alpha=0.4)
txt.savefig('H-X.png', dpi=300, bbox_inches='tight')

print('H was saved.')