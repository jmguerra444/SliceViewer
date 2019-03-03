function [lp_image,hp_image]=binomf(a,N)
%Binomial filter for images where(two dimensions): 
%a is the inputmatrix
%N is the filter order
%the output lp_image (image of low frequency)
%hp_image (image og high frequencies)
%Jorge Mario Guerra (06-06-16)
b=1;
c=[1 1;1 1];
mini=min(a(:));
a=a-mini;
for i=1:N
    b=conv2(b,c);
end
filter=b/max(b(:));
filter=imresize(filter,size(a));
A=fft2(a);
A=fftshift(A);
flp_image=filter.*A; %teorema de convolución
fhp_image=abs(1-filter).*A;
lp_image=abs(ifft2(fftshift(flp_image)))+mini;
hp_image=abs(ifft2(fftshift(fhp_image)))+mini;
end