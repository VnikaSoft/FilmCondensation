import numpy as np
import matplotlib.pyplot as txt

data = np.loadtxt('Alpha-X.txt')

Num = data[:, 0]
X = data[:, 1]
Th = data[:, 2]
Corr = data[:, 3]
data = np.loadtxt('exp.txt')
x_exp= data[:, 0]
a_exp = data[:, 1]

txt.plot(X, Th, '-',  markersize=1,  label='Theoretical')
txt.plot(X, Num, 'o',  markersize=1,  label='Numerical (smooth film)')
txt.plot(X, Corr, 'o',  markersize=1,  label='Numerical(wavy film)')
txt.legend(loc='best', markerscale=3)
txt.plot(x_exp, a_exp, 'D',  markersize=2,  label='Experiment')
txt.legend(loc='best', markerscale=3)
txt.xlabel('X,m')
txt.ylabel('Alpha,W/(m²·K)')
txt.minorticks_on() 
txt.grid(which='major', linestyle='-', linewidth=0.7, alpha=0.7)  
txt.grid(which='minor', linestyle=':', linewidth=0.4, alpha=0.4)  
txt.savefig('Alpha-X.png', dpi=300, bbox_inches='tight')
print('Alpha-X was saved.')

txt.figure()
txt.xscale('log')
txt.yscale('log')

txt.plot(X, Th, '-',  markersize=1,  label='Theoretical')
txt.plot(X, Num, 'o',  markersize=1,  label='Numerical (smooth film)')
txt.plot(X, Corr, 'o',  markersize=1,  label='Numerical(wavy film)')
txt.xlabel('X,m')
txt.ylabel('Alpha,W/(m²·K)')
txt.minorticks_on() 
txt.grid(which='major', linestyle='-', linewidth=0.7, alpha=0.7)  
txt.grid(which='minor', linestyle=':', linewidth=0.4, alpha=0.4)  
txt.savefig('Alpha-X-LOG.png', dpi=300, bbox_inches='tight')
print('Alpha-X-LOG was saved.')
