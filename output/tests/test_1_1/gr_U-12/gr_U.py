import numpy as np
import matplotlib.pyplot as txt

data = np.loadtxt('U-1-8.txt')

y = data[:, 0]
U1 = data[:, 1]


data = np.loadtxt('U-2-8.txt')
U2 = data[:, 1]

data = np.loadtxt('U-1-32.txt')
U12 = data[:, 1]
y2 = data[:, 0]
U_theor = data[:, 2]

data = np.loadtxt('U-2-32.txt')
U22 = data[:, 1]

txt.plot(y, U1, '^',  color='C0', markersize=1,  label='1_order_bc_8_points')
txt.plot(y, U2, 'o',  color='C1', markersize=1,  label='2_order_bc_8_points')
txt.plot(y2, U12, '^',  color='C2', markersize=1,  label='1_order_bc_32_points')
txt.plot(y2, U22, 'o',  color='C3', markersize=1,  label='2_order_bc_32_points')
txt.plot(y2, U_theor, '-', color='C4',  markersize=1,  label='analitical')
txt.legend(loc='best', markerscale=3)
txt.xlabel('Y,m')
txt.ylabel('U,m/s')
txt.minorticks_on() 
txt.grid(which='major', linestyle='-', linewidth=0.7, alpha=0.7)  
txt.grid(which='minor', linestyle=':', linewidth=0.4, alpha=0.4) 
txt.savefig('U.png', dpi=300, bbox_inches='tight')
print('U was saved.')