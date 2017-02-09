function [ Rf ] =  myRadonTrans(inputImage,deltas)
% myRadonTrans Computes radon transform of input image
t = -90:5:90;
[~,dimt]=size(t);
theta = 0:5:175;
[~,dimtheta]=size(theta);
varh=0;
h = waitbar(varh,'computing Radon transform');
Rf=zeros(dimt,dimtheta);
i=0;
for tt = t
    i=i+1;
    func = @(y)myIntegration(inputImage,tt,y,deltas);
    Rf(i,:)=arrayfun(func,theta);
    waitbar(double(i/dimt));
end
close(h)
end
