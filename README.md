# Numerical Methods and Optimization

This repository contains a collection of laboratory reports for Numerical Methods
and Optimization at the Wrocław University of Science and Technology.

## TODO

- [ ] Create a top-level `bibliography.bib` file that the source TeX files for each
 report use.
- [ ] Refine Lab 1 Problem 2. Develop the description of the LU factorisation
 and consider changing the method not involving P and Q matrices.

## Compilation

To compile on Ubuntu 24.04:

```sh
sudo apt-get install -y \
  fonts-cmu \
  texlive-full
sudo fc-cache -f -v
make
```

## Acknowledgement

I want to thank:

- Paulina Porczyńska, for the first version of the WUST report title page;
- Kacper Chmielewski, Kamil Czop, and Kinga Otczyk, for surviving the laboratories with
 perfectionist me.
