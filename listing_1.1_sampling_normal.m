% Code exploring the normal distribution

mu = 100; % mean
sigma = 15; % sd
xmin = 70; % min for pdf and cdf plot
xmax = 140; % max for plot
n = 100; % number of points on the plot
k = 10000 % number of samples for histogram

% create a set of values from xmin to xmax
x = linspace (xmin, xmax, n)
p = normpdf (x, mu, sigma) % pdf
c = normcdf (x, mu, sigma) % cdf

figure (1); clf;

subplot (1, 3, 1);
plot (x, p, 'k-');
xlabel ('x'); ylabel ('pdf');
title ('Probability Density Function');

subplot (1, 3, 2);
plot (x, c, 'k-');
xlabel ('x'); ylabel ('cdf');
title ('Cumulative Density Function');

% draw k random numbers from a N (mu, sigma) distribution
y = normrnd(mu, sigma, k, 1);

subplot (1,3,3);
hist(y, 20);
xlabel ('x'); ylabel ('frequencies');
title ('Histogram of random values');