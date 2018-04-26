data {
          int<lower=0> N;     // sample size
          int<lower=0> Y[N];  // response variable
          int N_new; // prediction size
}
parameters {
          real beta;
          real r[N];
          real<lower=0> sigma;
}
transformed parameters {
          real q[N];
        
          for (i in 1:N) {
                   q[i] = inv_logit(beta + r[i]); // 生存確率
          }
}
model {
          for (i in 1:N) {
                Y[i] ~ binomial(8, q[i]); // 二項分布
          }
          beta ~ normal(0, 100);      // 無情報事前分布
          r ~ normal(0, sigma);       // 階層事前分布
          sigma ~ uniform(0, 1.0e+4); // 無情報事前分布
}

generated quantities{
        real y_new[N_new]; // Make N_new y predictions
        real q_new[N_new]; // Make N_new q to use for y
        real r_new[N_new]; // Make N_new r to use for q
        for(n in 1:N_new){
                r_new[n] = normal_rng(0, sigma);
                q_new[n] = inv_logit(beta + r_new[n]); // this needs to be logit
                y_new[n] = binomial_rng(8, q_new[n]);
        }
}