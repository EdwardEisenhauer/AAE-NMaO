# Numerical Methods and Optimization Project

This directory contains source code for the Argument of Latitude Optimisation
in the Satellite Constellation.

The goal is to design an algorithm minimising the relative difference of the
arguments of latitude of the satellites in the constellation.

We assume there are six satellites in our constellation. They have the same
orbital parameters, but different arguments of latitude. Different forces acting
on the satellites perturb their orbit. We want the satellites to be equally
spaced on the orbit. The algorithm should determine which satellites should be
moved, in which direction and how far. The orbital transfers should keep the
fuel level on different satellites as similar as possible.

The optimisation criteria are:

1. The relative arguments of latitude of each satellite are as similar
   as possible.
2. Each satellite consumes as little fuel as possible for the orbital transfer
   satisfying criterion (1).
3. The fuel levels on the satellites are as similar as possible.

## Mathematical Approach

We ignore all forces acting on the satellites, so that the fuel levels
correspond directly to the delta v.
