% Code exploring the normal distribution

lambda = 1;
xmin = 0; % min for pdf and cdf plot
xmax = 10; % max for plot
n = 100; % number of points on the plot
k = 10000 % number of samples for histogram

% create a set of values from xmin to xmax
x = linspace (xmin, xmax, n)
a = exppdf (x, lambda) % pdf


figure (1); clf;

subplot (1, 2, 1);
plot (x, a, 'k-');
xlabel ('x'); ylabel ('pdf');
title ('Probability Density Function');

% draw k random numbers from a N (mu, sigma) distribution
seed=1; rand ('state', seed);
u = rand (1,k);
y = -1 * log(1 - u) * lambda;


subplot (1,2,2);
hist(y, 20);
xlabel ('x'); ylabel ('frequencies');
title ('Histogram of random values');