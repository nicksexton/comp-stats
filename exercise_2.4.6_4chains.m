# Use the Metropolis procedure to sample from Cauchy density
1; # not a function file
function y = cauchy(theta)
  # returns the unnormalized density of the cauchy distribution
  y = 1 ./ (1 + theta .^ 2);
end


# Initialise the Metropolis sampler
T = 2000; # max iterations
burnin = 500; # samples to exclude
# burnin = 1; # samples to exclude
sigma = 1.5 # std dev of normal proposal density
thetamin  = -30; thetamax = 30; # define a range for starting values
theta = zeros(T, 4); # init storage space for our samples
# seed=1; rand('state', seed); randn('state',seed); # set the random seed
theta(1,:) = unifrnd (thetamin, thetamax, 1,4);



# start sampling
t = 1;
while t < T # iterate until we have T samples
  t=t+1;
  # propose a new value for theta using a normal proposal density
  theta_star = normrnd (theta(t-1,:), sigma);
  # calculate the acceptance ratio
  alpha = zeros(1,4);
  for i = 1:4
    alpha(1,i) = min ([ 1 (cauchy( theta_star(1,i)) / cauchy (theta(t-1,i) ))]);
  end
  # draw a uniform deviate from [0. 1]

  # do we accept this proposal?
  for (i = 1:columns(theta))
  u = rand;
    if u < alpha(i)
      theta(t,i) = theta_star(1,i); # if so, proposal becomes a new state
    else
      theta(t,i) = theta(t-1,i); # if not, copy old state
    endif
  end
end

# Display histogram of our samples
figure (1); clf;
subplot (3,1,1);
nbins = 200;
thetabins = linspace (thetamin, thetamax, nbins);
counts = hist (theta(burnin:T,1), thetabins) +...
    hist (theta(burnin:T,2), thetabins) +...
    hist (theta(burnin:T,3), thetabins) +...
    hist (theta(burnin:T,4), thetabins);
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

  stairs (theta(:,1), 1:T, 'k-r');
  hold on;

  stairs (theta(:,2), 1:T, 'k-g');
  hold on;

  stairs (theta(:,3), 1:T, 'k-b');
  hold on;

  stairs (theta(:,4), 1:T, 'k-m');
  hold on;

ylabel ('t'); xlabel ('\theta');
set (gca, 'YDir', 'reverse');
xlim ([thetamin thetamax]);




accepted(1) / sum(accepted)
