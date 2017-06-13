function [objective,Ds,D] = LevenbergMarquardtModified(g,Sg,S0,b0,L_init)
%LEVENBERGMARQUARDTMODIFIED optimizes the 2D Diffusion tensor model
%parameters using modified LEVENBERG MARQUARDT algorithm
max_iter = 200;
objective = [];
Ds = [];

learning_rate = 0.001;
lambda = 0.1;
epsilon = 0.0000001;

L = L_init;
iter = 1;
while(iter<max_iter)
    [objective_pre,residue] = getLogObjective(g,Sg,S0,b0,L);
    J= getObjectiveJacobi(g,S0,b0,L);
    delta = -learning_rate *(((J'*J)+lambda*diag(diag(J'*J)))\J'*residue);
    L_delta = [delta(1),0;delta(2),delta(3)];
    L_new = L+L_delta;
    [objective_new,~] = getLogObjective(g,Sg,S0,b0,L_new);
    if(objective_new<objective_pre)
        L = L_new;
        learning_rate = learning_rate*1.1;
        objective_pre = objective_new;
    else
        learning_rate = learning_rate/2;
    end
    Ds(iter,:,:) = L*L';
    D = L*L';
    objective(iter) = objective_pre;
    if(learning_rate < epsilon)
        break
    end
    iter= iter+1;
end
end

