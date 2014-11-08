# Use the Metropolis procedure to sample from Cauchy density
1; # not a function file
function y = cauchy(theta)
  # returns the unnormalized density of the cauchy distribution
  y = 1 ./ (1 + theta .^ 2);
end


# Initialise the Metropolis sampler
T = 5000; # max iterations
burnin = 500; # samples to exclude
sigma = 1.5 # std dev of normal proposal density
thetamin  = -30; thetamax = 30; # define a range for starting values
theta = zeros(1, T); # init storage space for our samples
# seed=1; rand('state', seed); randn('state',seed); # set the random seed
theta(1) = unifrnd (thetamin, thetamax);
accepted = [0 0]; # accept : reject


# start sampling
t = 1;
while t < T # iterate until we have T samples
  t=t+1;
  # propose a new value for theta using a normal proposal density
  theta_star = normrnd (theta(t-1), sigma);
  # calculate the acceptance ratio
  alpha = min ([ 1 (cauchy( theta_star) / cauchy (theta(t-1) ))]);
  # draw a uniform deviate from [0. 1]
  u = rand;
  # do we accept this proposal?
  if u < alpha
     theta(t) = theta_star; # if so, proposal becomes a new state
     accepted(1) ++;
  else
    theta(t) = theta(t-1); # if not, copy old state
    accepted(2) ++;
  end
end

# Display histogram of our samples
figure (1); clf;
subplot (3,1,1);
nbins = 200;
thetabins = linspace (thetamin, thetamax, nbins);
counts = hist (theta(burnin:T), thetabins);
bar (thetabins, counts/sum(counts), 'k');
xlim ([thetamin thetamax]);
xlabel ('\theta'); ylabel ('p(\theta)');

# overlay the theoretical density
y = cauchy (thetabins);
hold on;
plot (thetabins, y/sum(y), 'r--', 'LineWidth', 3);
set (gca, 'YTick', []);

# display history of our samples
subplot (3,1,2:3);
stairs (theta, 1:T, 'k-');
ylabel ('t'); xlabel ('\theta');
set (gca, 'YDir', 'reverse');
xlim ([thetamin thetamax]);

accepted(1) / sum(accepted)
