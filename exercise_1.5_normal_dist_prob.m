# assume IQ coefficients are normally distributed, mean=100 and SD= 15
# what is probability that random individual has 110 < IQ < 13o

% sum(normpdf ([110:130], 100, 15)) 

normcdf (130, 100, 15) - normcdf(110, 100, 15)
