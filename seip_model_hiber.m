%This model is for calculating P only for swarming and hibernation
% Hibernation Model
function dydt = seip_model_hiber(t,y,beta,phi,tao, mu, omega, nu, K_pd, delta)
  S = y(1);
  E = y(2);
  I = y(3);
  P = y(4);
  % Equations of the model described above
  dS = -(beta* I + phi * P)*S - mu * S;
  dE = (beta* I + phi * P)*S - (tao + mu)*E;
  dI = tao * E - (delta + mu) * I;
  dP = (omega*I + nu*P) * (1 - P /K_pd);
  dydt = [dS;dE;dI;dP];
end