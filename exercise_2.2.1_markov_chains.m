% Code exploring the normal distribution
1; # not a function file


function xt_0 = transition (xt_1) # x at t0, x at t-1. 
  xt_0 = betarnd (200 * (0.9 * xt_1 + .05), 200 * (1 - 0.9 * xt_1 - .05));

end


k = 1000; # length of each chain

t = zeros(k,4);
t(1,:) = rand(1,4);

for (i = 2:k) 
  t(i,:) = transition(t(i-1,:));
end


figure (1); clf;
plot (t)