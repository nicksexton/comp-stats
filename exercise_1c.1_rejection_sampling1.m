% Rejection sampling the beta distribution

alpha = 2;
beta = 1;
xmin = 0; % min for pdf and cdf plot
xmax = 1; % max for plot
n = 100; % number of points on the plot
k = 100000 % number of samples for histogram

% create a set of values from xmin to xmax
x = linspace (xmin, xmax, n)
b = betapdf (x, alpha, beta) % pdf



% Create a uniform proposal distribution, u, and target distribution, t
seed=1; rand ('state', seed);
u = rand (2,k);
t = zeros (2,k);
counter = 1;
for (i = 1:k)
  if u(2,i) <= 0.5*u(1,i) 
    t(:,counter) = u(:,i);
    counter ++;
  endif
end
t = t(:,1:counter+1);


figure (1); clf;

subplot (1, 3, 1);
plot (x, b, 'k-');
xlabel ('x'); ylabel ('pdf');
title ('Probability Density Function');

bhist = betarnd (alpha, beta, 1,k);
subplot (1, 3, 2);
hist (bhist, 40);
xlabel ('x'); ylabel ('cdf');
title ('Beta distribution');


subplot (1,3,3);
hist(t(1,:), 40);
xlabel ('x'); ylabel ('frequencies');
title ('Rejection Sampling');