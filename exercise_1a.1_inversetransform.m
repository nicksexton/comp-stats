# Simulate the distribution observed int he human random digit
# generation task

# Probabilities for each digit
theta = [0.000; ... # digit 0
	 0.100; ... # digit 1
	 0.090; ... # digit 2
	 0.095; ... # digit 3
	 0.200; ... # digit 4
	 0.175; ... # digit 5
	 0.190; ... # digit 6
	 0.050; ... # digit 7
	 0.100; ... # digit 8
	 0.000 ]    # digit 9

cumtheta = zeros (rows(theta),1);
for i = 1:rows(theta)
  cumtheta(i) = sum(theta(1:i));
end

% fix the random number generator
seed=1; rand ('state', seed);

% draw k random vbariables
k=10000;
digitset = 0:9;
Y = rand (k);
Z = zeros (k,1);

for (i = 1:k)
     j = 1;
     while (cumtheta(j) < Y(i))
       j ++;
     end
     Z(i) = j-1;
end

% create a new figure
figure (1); clf;

% show the histogram of the simulated draws
counts = hist (Z, digitset);
bar (digitset, counts, 'k');
xlim ([-0.5, 9.5]);
xlabel ('Digit')
ylabel ('Frequency')
title ('Distribution of simulated draws of human digit generator');
