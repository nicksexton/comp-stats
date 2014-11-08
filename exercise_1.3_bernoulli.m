% Code sampling from the bernoulli distribution

function result = bernoulli_trial (theta)

  if unifrnd (0, 1) < theta
    result = 1;
  else
    result = 0;
  endif

end

theta = 0.7
n = 10 ; % samples


x = zeros(1,n)
for (i = 1:n)
  x(:,i) = bernoulli_trial (theta);
end

x