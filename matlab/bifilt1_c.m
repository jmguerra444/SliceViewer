function y=bifilt1_c(x,W,sigma)
%Bilateral filter applied in C

%PRECOMPUTATIONS
%created by Karen Xu, 06/06/2011

%Double check signal is a row/column vector.
if size(x,1)>size(x,2)
    x=x';
end
sig1=sigma(1);
sig2=sigma(2);
[X] = (-W:W);
h = exp(-(X.^2)/(2*sig1^2));
%Create distance weights
%x=padvector(x,W); %updated to run ok

%Actual bilateral filter application
y=bif(x,h,W,sig2);
y(1:W)=x(1:W);
y(end-W+1:end)=x(end-W+1:end);
%y=y(W+1:end-W);
