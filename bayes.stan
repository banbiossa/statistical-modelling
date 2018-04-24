data{
        int<lower=0>    N;
        int<lower=0>    M;
        int<lower=0>    y[N];
}

parameters{
        real<lower=0>   alpha;
        real            beta[N];
        real<lower=0>   sigma;
}

transformed parameters{
        real z[N];
        real p[N];
        for(i in 1:N){
                z[i] <- alpha + beta[i];
                p[i] <-  inv_logit(z[i]);
        }
}

model{
        beta ~ normal(0,sigma);
        for(i in 1:N) y[i] ~ binomial(M,p[i]);
}

generated quantities{
        int y_hat[N];
        for(i in 1:N)
                y_hat[i] <- binomial_rng(M, p[i]);
}