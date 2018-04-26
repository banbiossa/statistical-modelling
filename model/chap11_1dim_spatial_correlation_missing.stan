// http://statmodeling.hatenablog.com/entry/markov-field-model
data {
   int<lower=1> N_obs;
   int<lower=1> N_miss;
   int<lower=0> Y[N_site];
}

parameters {
   real r[N_site];
   real<lower=0> s_r;
}

model {
   for (j in 2:N_site)
      r[j] ~ normal(r[j-1], s_r);
   for (j in 1:N_site)
      Y[j] ~ poisson_log(r[j]);
}

generated quantities {
   real<lower=0> Y_mean[N_site];
   for (j in 1:N_site)
      Y_mean[j] = exp(r[j]);
}