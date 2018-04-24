data{
        int<lower=1>    N;
        real            y[N];
        
}

parameters{
        real    mu;
        real<lower=0> sigma;
}

model {
        mu ~ normal(0,1000);
        sigma ~ normal(0,1000);
        y ~ normal(mu, sigma);
}

