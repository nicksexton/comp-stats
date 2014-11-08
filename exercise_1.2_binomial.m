% Code exploring the binomial distribution

N = 10; % mean
theta = 0.7; % sd
xmin = 0; % min for pdf and cdf plot
xmax = 10; % max for plot
n = 11; % number of points on the plot
k = 1000 % number of samples for histogram

% create a set of values from xmin to xmax
x = linspace (xmin, xmax, n)
p = binopdf (x, N, theta) % pdf
c = binocdf (x, N, theta) % cdf

figure (1); clf;

subplot (1, 3, 1);
bar (x, p);
xlabel ('x'); ylabel ('pdf');
title ('Probability Density Function');

subplot (1, 3, 2);
bar (x, c);
xlabel ('x'); ylabel ('cdf');
title ('Cumulative Density Function');

% draw k random numbers from a binomial (N, theta) distribution
y = binornd(N, theta, 1,k);

subplot (1,3,3);
hist(y, x);
xlabel ('x'); ylabel ('frequencies');
title ('Histogram of random values');