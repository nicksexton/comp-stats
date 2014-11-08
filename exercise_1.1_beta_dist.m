% Code exploring the normal distribution

lambda = 1;
xmin = 0; % min for pdf and cdf plot
xmax = 1; % max for plot
n = 100; % number of points on the plot
k = 1000 % number of samples for histogram

% create a set of values from xmin to xmax
x = linspace (xmin, xmax, n)
a = exppdf (x, lambda) % pdf


figure (1); clf;

subplot (1, 3, 1);
plot (x, a, 'k-');
xlabel ('x'); ylabel ('pdf');
title ('Probability Density Function');

# subplot (1, 3, 2);
# plot (x, c, 'k-');
# xlabel ('x'); ylabel ('cdf');
# title ('Cumulative Density Function');

# % draw k random numbers from a N (mu, sigma) distribution
# y = betarnd(alpha, beta, k, 1);

# subplot (1,3,3);
# hist(y, 20);
# xlabel ('x'); ylabel ('frequencies');
# title ('Histogram of random values');