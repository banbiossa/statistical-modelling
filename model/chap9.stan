
data {
        int<lower=0> N;     // number of data
        real X[N];          // explanatory variable
        real MeanX;         // mean of X
        int<lower=0> Y[N];  // response variable
}
parameters {
        real beta1;
        real beta2;
}
transformed parameters {
        real<lower=0> lambda[N];

        for (i in 1:N) {
                lambda[i] = exp(beta1 + beta2 * (X[i] - MeanX));
        }
}
model {
        for (i in 1:N) {
                Y[i] ~ poisson(lambda[i]);
        }
        beta1 ~ normal(0, 100);
        beta2 ~ normal(0, 100);
}