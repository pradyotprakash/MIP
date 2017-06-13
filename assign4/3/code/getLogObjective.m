function [objectiveVal,residues] = getLogObjective(g,Sg,S0,b0,L_init)
%getLogObjective: returns the log of objective function
D = L_init*(L_init');
Dg = (D*g')';
gDg = sum(g.*Dg,2);
Sg_est = S0*exp(-b0*gDg);
residues = Sg-Sg_est;
objectiveVal = log(sum(abs(residues.*residues)));
end

