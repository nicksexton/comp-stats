# Chapter 2 - Metropolis procedure to sample from bivariate exponential
# Blockwise updating. Use a uniform proposal distribution

1; # not a function file

function y = bivexp (theta1, theta2)
  # returns the density of a bivariate exponential function
  lambda1 = 0.5; # constants...
  lambda2 = 0.1;
  lambda = 0.01;
  maxval = 7;
  y = exp ( -(lambda1+lambda)*theta1 - (lambda2+lambda)*theta2 - \
	   lambda*maxval );
end


## Initialise the Metropolis sampler
T = 10000;
thetamin = [ 0 0 ]
thetamax = [ 8 8 ]
seed=1; rand ('state', seed); randn ('state', seed); # set random seed
theta = zeros (2, T);
theta(1,1) = unifrnd (thetamin(1), thetamax(1));
theta(2,1) = unifrnd (thetamin(2), thetamax(2));

# Start sampling
t=1;
while t < T # iterate until we have T samples
  t = t + 1;
  # propose a new value for theta
  # theta_star = unifrnd (thetamin, thetamax, 2, 1); ##### ??? Error in
  # source?
  theta_star = unifrnd (thetamin(1), thetamax(1), 2, 1); ##### ??? Error in source?
  pratio = bivexp (theta_star(1), theta_star(2)) / ... 
      bivexp (theta(1,t-1), theta(2,t-1));
  alpha = min ( [1 pratio]); # calculate the acceptance ratio
  u = rand; # draw a uniform deviate from [0, 1]
  if u < alpha # do we accept this proposal?
    theta (:,t) = theta_star; # proposal becomes new value of theta
  else
    theta(:,t) = theta(:,t-1); # copy old value of theta
  end
end

# Display histogram of our samples
figure (1); clf;
subplot (1,2,1);
nbins = 10;
thetabins1 = linspace (thetamin(1), thetamax(1), nbins);
thetabins2 = linspace (thetamin(2), thetamax(2), nbins);
hist3(transpose(theta), 'Edges', {thetabins1 thetabins2});
xlabel ('\theta_1'); ylabel ('\theta_2'); zlabel ('counts')
az = 61, e1 = 30;
view (az, e1);

# Plot the theoretical density
subplot (1,2,2);
nbins = 20;
thetabins1 = linspace (thetamin(1), thetamax(1), nbins);
thetabins2 = linspace (thetamin(2), thetamax(2), nbins);
[theta1grid, theta2grid] = meshgrid (thetabins1, thetabins2);
ygrid = bivexp (theta1grid, theta2grid);
mesh (theta1grid, theta2grid, ygrid);
xlabel ('\theta_1'); ylabel ('\theta_2'); zlabel ('f(\theta_1,\theta_2')
view (az, e1);
    
  