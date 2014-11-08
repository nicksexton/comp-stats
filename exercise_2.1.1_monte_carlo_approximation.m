% Code exploring the normal distribution

alpha = 3;
beta = 5;

k = 10000 % number of samples 


expectation = (1/k) * sum(betarnd (alpha, beta, 1,k))

analytic = alpha / (alpha + beta)