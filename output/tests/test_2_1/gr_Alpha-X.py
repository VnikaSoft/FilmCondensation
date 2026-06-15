import numpy as np
import matplotlib.pyplot as txt

data = np.loadtxt('Alpha-X.txt')

Num = data[:, 0]
X = data[:, 1]
Th = data[:, 2]


txt.plot(X, Num, 'o',  markersize=1,  label='Numerical')
txt.plot(X, Th, '-',  markersize=1,  label='Theoretical')
txt.legend(loc='best')
txt.xlabel('X,m')
txt.ylabel('Alpha,W/(m²·K)')
txt.minorticks_on()  
txt.grid(which='major', linestyle='-', linewidth=0.7, alpha=0.7)  
txt.grid(which='minor', linestyle=':', linewidth=0.4, alpha=0.4)  
txt.legend(loc='best', markerscale=3)
txt.savefig('Alpha-X.png', dpi=300, bbox_inches='tight')
print('Alpha-X was saved.')

txt.figure()
txt.xscale('log')
txt.yscale('log')

txt.plot(X, Num, 'o',  markersize=1,  label='Numerical')
txt.plot(X, Th, '-',  markersize=1,  label='Theoretical')
txt.legend(loc='best', markerscale=3)
txt.xlabel('X,m')
txt.ylabel('Alpha,W/(m²·K)')
txt.minorticks_on()  
txt.grid(which='major', linestyle='-', linewidth=0.7, alpha=0.7)  
txt.grid(which='minor', linestyle=':', linewidth=0.4, alpha=0.4)  
txt.savefig('Alpha-X-LOG.png', dpi=300, bbox_inches='tight')
print('Alpha-X-LOG was saved.')