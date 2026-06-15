import numpy as np
import matplotlib.pyplot as txt

data = np.loadtxt('H-X-1101-32.txt')
H1101 = data[:, 0]
X1101 = data[:, 1]
data = np.loadtxt('H-X-551-32.txt')
H551 = data[:, 0]
X551 = data[:, 1]
data = np.loadtxt('H-X-276-32.txt')
H276 = data[:, 0]
X276 = data[:, 1]

#####################################
data = np.loadtxt('H4-X-1101-32.txt')
H41101 = data[:, 0]
X41101 = data[:, 1]
data = np.loadtxt('H4-X-551-32.txt')
H4551 = data[:, 0]
X4551 = data[:, 1]
data = np.loadtxt('H4-X-276-32.txt')
H4276 = data[:, 0]
X4276 = data[:, 1]


txt.plot(X1101, H1101, 'o',  markersize=2,  label='H, NI=1101')
txt.plot(X551, H551, 'o',  markersize=2,  label='H, NI=551')
txt.plot(X276, H276, 'o',  markersize=2,  label='H, NI=276')

txt.plot(X41101, H41101, 'o',  markersize=2,  label='H/4, NI=1101')
txt.plot(X4551, H4551, 'o',  markersize=2,  label='H/4, NI=551')
txt.plot(X4276, H4276, 'o',  markersize=2,  label='H/4, NI=276')

txt.xlim(0.0, 0.0004)
txt.xlabel('X,m')
txt.ylabel('H,m')
txt.legend(loc='best', markerscale=1.5)
txt.minorticks_on() 
txt.grid(which='major', linestyle='-', linewidth=0.7, alpha=0.7)  
txt.grid(which='minor', linestyle=':', linewidth=0.4, alpha=0.4) 
txt.savefig('H-X.png', dpi=300, bbox_inches='tight')
print('H was saved.')