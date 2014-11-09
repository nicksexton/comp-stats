## Chapter 2. Metropolis procedure to sample from Bivariate Normal
# Component-wise updating. Use a normal proposal distribution

## Parameters of the bivariate normal
mu = [ 0 0 ];
sigma = [  1  0.3; ...
	  0.3   1 ];

## Initialise the Metropolis sampler
T = 5000; # Number of samples
propsigma = 1; # Std Dev of proposal distribution
thetamin = [ -3 -3 ] # Define minimum for theta1 and theta2
thetamax = [  3  3 ] # Define maximum for theta1 and theta2
seed=1; rand('state', seed); randn('state', seed);
state = zeros (2, T); # Init storage space for the state of the sampler
theta1 = unifrnd (thetamin(1), thetamax(1)); # start value for theta1
theta2 = unifrnd (thetamin(2), thetamax(2)); # start value for theta2
t = 1; # initialise iteration at 1

state(1,t) = theta1; # save the current state
state(2,t) = theta2;

## Start Sampling
while t < T # Iterate until we have T samples
  t = t + 1;

  ## Propose a new value for Theta1
  new_theta1 = normrnd (theta1, propsigma);
  pratio = mvnpdf ( [ new_theta1 theta2 ], mu, sigma) / ...
      mvnpdf ( [ theta1 theta2 ], mu, sigma);
  alpha = min ( [ 1 pratio ] ); # calculate the acceptance ratio
  u = rand; # uniform deviate from ( 0 1 )
  if u < alpha # do we accept this proposal?
    theta1 = new_theta1; # proposal becomes the new value for theta1
  end

  ## Propose a new value for Theta2
  new_theta2 = normrnd (theta2, propsigma);
  pratio = mvnpdf ( [ theta1 new_theta2 ], mu, sigma) / ...
      mvnpdf ( [ theta1 theta2 ], mu, sigma);
  alpha = min ( [ 1 pratio ] ); # calculate the acceptance ratio
  u = rand; # uniform deviate from ( 0 1 )
  if u < alpha # do we accept this proposal?
    theta2 = new_theta2; # proposal becomes the new value for theta1
  end

  # save state
  state(1,t) = theta1;
  state(2,t) = theta2;
end

## Display histogram of our samples
figure (1); clf;
subplot (1,2,1);
nbins = 12;
thetabins1 = linspace (thetamin(1), thetamax(1), nbins);
thetabins2 = linspace (thetamin(2), thetamax(2), nbins);
hist3(transpose(state), 'Edges', {thetabins1 thetabins2});
xlabel ('\theta_1'); ylabel ('\theta_2'); zlabel ('counts')
az = 61, e1 = 30;
view (az, e1);

# Plot the theoretical density
subplot (1,2,2);
nbins = 50;
thetabins1 = linspace (thetamin(1), thetamax(1), nbins);
thetabins2 = linspace (thetamin(2), thetamax(2), nbins);
[theta1grid, theta2grid] = meshgrid (thetabins1, thetabins2);
zgrid=mvnpdf ( [theta1grid(:), theta2grid(:)], mu, sigma);
zgrid=reshape (zgrid, nbins, nbins);
surf (theta1grid, theta2grid, zgrid);
xlabel ('\theta_1'); ylabel ('\theta_2'); zlabel ('f(\theta_1,\theta_2')
view (az, e1);
xlim([thetamin(1), thetamax(1)]); ylim([thetamin(2), thetamax(2)]);