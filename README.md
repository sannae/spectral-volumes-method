# Spectral-volumes-method
### Introduction
This repository includes my MSc thesis work on the Spectral Volumes method - first proposed by Dr. [Z.J.Wang](https://www.sciencedirect.com/science/article/pii/S0021999102970415) - applied to an [Inertial Confinement Fusion (ICF)](https://en.wikipedia.org/wiki/Inertial_confinement_fusion) environment. 
The code is part of a benchmark Matlab reduction used for testing the actual code, which is part of the [Los Alamos Plasma Simulations (LAPS) project](https://www.researchgate.net/publication/258592313_The_design_and_implementation_of_Los_Alamos_PLasma_Simulation_LAPS_code), property of the Los Alamos National Laboratory, New Mexico, US. 
### Components
* The folder `SV-1D` contains the 1-dimensional Matlab reduction of the Spectral Volumes method applied to Euler's non-viscous equations. Initial conditions and further parameters are available in the comments.
* The folder `SV-2D` contains the 2-dimensional Matlab reduction of the Spectral Volumes method applied to Euler's non-viscous equations. Initial conditions and further parameters are available in the comments. The script automatically produces and runs a movie file with the simulation performed.
Both environment simulates the center of an ICF target, starting from the moment where a peak of density and temperature is produced at the center of the target due to high-intensity laser interaction.
