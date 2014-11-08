% Code exploring the normal distribution

alpha = 1.5;
beta = 4;

k = 100000 % number of samples 

sample = gamrnd (alpha, beta, 1,k);
expectation = (1/k) * sum(sample)
ssqerror = (sample - expectation).^2;
variance = sum(ssqerror)/k


analytic = alpha * beta^2