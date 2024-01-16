"""Set the full path to the flow executable and flags"""
flow --linear-solver=cprw --newton-min-iterations=5 --enable-tuning=true --enable-opm-rst-file=true --enable-well-operability-check=false --min-time-step-before-shutting-problematic-wells-in-days=1e-99 --linear-solver-ignore-convergence-failure=false

"""Set the model parameters"""
saltprec uniform     #Model (co2store/h2store/co2eor/saltprec)
cake 60    #Grid type (radial/cartesian/cake) and size (width/theta/theta [in degrees])
10000 100       #Reservoir dimensions [m] (Lenght and height)
400 20 7.1  #Number of x- and z-cells [-] and exponential factor for the telescopic x-gridding
0.025 0 0      #Well diameter [m], well transmiscibility (0 to use the computed one internally in Flow), and remove the smaller cells than the well diameter
9.6e6 40 0  #Pressure [Pa] on the top, uniform temperature [°], and initial phase in the reservoir (0 wetting, 1 non-wetting)
-1 0    #Pore volume multiplier on the boundary [-] (0 to use well producers instead) and deactivate cross flow within the wellbore (see XFLOW in OPM Manual)
0 2 10       #Activate perforation [-], number of well perforations [-], and number of x-direction cells [-]
1 0 0 8.5e-10 #Number of layers [-], hysteresis (1 to activate), and econ for the producer (for h2 models)
138 268 2153 0.8 0.8 1001 0 default #Ini salt conc [kg/m3], salt sol lim [kg/m3], prec salt den [kg/m3], gamma [-], phi_r [-], npoints [-], and threshold [-]  (all entries for saltprec)
0            #The function for the reservoir surface

"""Set the saturation functions"""
((sw - swi) / (1.0 - swi - sni)) ** 4.0    #Wetting rel perm saturation function [-]
(1-((sw - swi) / (1.0 - swi - sni)) ** 2.0) * (1-(sw - swi) / (1.0 - swi - sni)) ** 2    #Non-wetting rel perm saturation function [-]
pec * (((sw - swi) / (1. - swi)) ** (-(1./npe)) - 1.) ** (1. - npe) #Capillary pressure saturation function [Pa]

"""Properties sat functions"""
"""swi [-], swrg [-], krg [-], krw [-], pe [Pa], threshold cP evaluation, ignore swi for cP?"""
SWI1 0.25 SNI1 0.05 KRW1 1. KRN1 1. PEC1 1.96e3 NKRW1 0.487 NKRN1 0.487 NPE1 0.457 THRE1 8e-4 IGN1 0

"""Properties rock"""
"""Kx [mD], Kz [mD], phi [-], thickness [m]"""
PERMX2 101.3 PERMZ2 101.3 PORO2 0.10 THIC1 100

"""Define the injection values""" 
"""injection time [d], time step size to write results [d], maximum time step [d], injected fluid (0 water, 1 co2), injection rates [kg/day]"""
6 6 .005 1 ${qrate*86400./6}
30 30 .01 1 ${qrate*86400./6}
37 37 .05 1 ${qrate*86400./6}
1022 73 .5 1 ${qrate*86400./6}
