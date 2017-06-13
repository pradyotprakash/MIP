tic;
%Data
g = [1,0; 0.866,0.5; 0.5,0.866; 0,1; -0.5, 0.866; -0.866, 0.5];
Sg = [complex(0.5045,-0.0217);complex(0.6874,0.0171); complex(0.3632,0.1789);
    complex(0.3483,0.1385);complex(0.2606, -0.0675); complex(0.2407,0.1517)];
S0 = 1;
b0 = 0.1;
%initial lower triangular matrix
L_init = [0.1,0;0.1,0.1];

%% Part (a)
[objective,Ds,D] = LevenbergMarquardtModified(g,Sg,S0,b0,L_init);
fprintf('Optimal D \n');
disp(D);

y=linspace(0,size(objective,2)-1,size(objective,2));
figure,plot(y,objective);
title('log(objective) vs Iteration')
xlabel('Iteration')
ylabel('log(Objective)')

figure,plot(y,abs(Ds(:,1,1)),y,abs(Ds(:,1,2)),y,abs(Ds(:,2,1)),y,abs(Ds(:,2,2)));
legend('D11','D12','D21','D22')
title('abs(D) vs Iteration')
xlabel('Iteration')
ylabel('Absolute values in D matrix')


figure,plot(y,real(Ds(:,1,1)),y,real(Ds(:,1,2)),y,real(Ds(:,2,1)),y,real(Ds(:,2,2)));
legend('D11','D12','D21','D22')
title('real(D) vs Iteration')
xlabel('Iteration')
ylabel('Real values in D matrix')

figure,plot(y,imag(Ds(:,1,1)),y,imag(Ds(:,1,2)),y,imag(Ds(:,2,1)),y,imag(Ds(:,2,2)));
legend('D11','D12','D21','D22')
title('imag(D) vs Iteration')
xlabel('Iteration')
ylabel('Imaginary values in D matrix')

%% Part (b)
disp('Principal direction found out using eigen decomosition is:');
[U,Dia,V] = svd(D);
disp(U(:,1)')

%% Part (c)
disp('Diffusion in the principal direction as compared to the diffusion in the direction orthogonal to it is:');
disp(Dia(1,1)/Dia(2,2));
toc;