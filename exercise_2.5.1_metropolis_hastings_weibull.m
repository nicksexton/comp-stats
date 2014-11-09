# Use the Metropolis procedure to sample from Cauchy density
1; # not a function file
function y = weibull_proportional(theta, a, b)
  # returns the unnormalized density of the weibull dist
#  y = theta .^ (b-1) .* exp (-1 .* theta .^ b);
  y = wblpdf (theta, a, b);
end




# function q = proposal_function (theta, A, B)
#   q = gamrnd (theta, A, B)
#   # use gamma distribution as proposal distribution
# end


# Initialise the Metropolis sampler
T = 12000;     # max iterations
burnin = 500; # samples to exclude
B = 1.9;      # parameter for target (weibull) distribution
A = 2;         # parameter for target (weibull) distribution
tau = 1.0;           # precision parameter for proposal (gamma) dist
thetamin  = 0; thetamax = 10; # define a range for starting values
theta = zeros(1, T); # init storage space for our samples
# seed=1; rand('state', seed); randn('state',seed); # set the random seed
theta(1) = unifrnd (thetamin, thetamax);
accepted = [0 0]; # accept : reject

# start sampling
t = 1;
while t < T # iterate until we have T samples
  t=t+1;

  # propose a new value for theta using proposal density
  theta_star = gamrnd (theta(t-1)*tau, 1/tau);



  # calculate the acceptance ratio
  proposal_density_ratio = gampdf (theta(t-1), theta_star*tau, 1/tau) / ...
      gampdf (theta_star, theta(t-1)*tau, 1/tau);

  alpha = min ([ 1 (weibull_proportional( theta_star, A, B) / ...
		    weibull_proportional(theta(t-1), A, B ))* ...
		proposal_density_ratio ]);
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
y = weibull_proportional (thetabins, A, B);
hold on;
plot (thetabins, y/sum(y), 'r--', 'LineWidth', 3);
set (gca, 'YTick', []);

# display history of our samples
subplot (3,1,2:3);
stairs (theta, 1:T, 'k-');
ylabel ('t'); xlabel ('\theta');
set (gca, 'YDir', 'reverse');
xlim ([thetamin thetamax]);

proportion_accepted = accepted(1) / sum(accepted)

expected_value = sum(theta(burnin:T)/(T-burnin))

variance = sum((theta(burnin:T) - expected_value).^2)/(T-burnin)