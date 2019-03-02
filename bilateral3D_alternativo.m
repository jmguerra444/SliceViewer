function out=bilateral3D_alternativo(Mn,W,sigma,sigmaZ,Flagg)
%%sigma=[sigma_d,sigma_r]
%Flagg
%0 encender y apagar
%1 ya está encendido
tic
cores=2;
pb = waitbar(0,'1','Name','Doing bilateral filter');
if Flagg
    waitbar(0,pb,'Starting');
else
    waitbar(0,pb,'Connecting processors');
    parell=parpool('perfil1',cores);
    waitbar(0.1,pb,'Please wait...');
end
vector=Mn(:);
vector=vector';
n=round(length(vector)/cores);
vectorf=zeros(length(vector),1);
v1=zeros(cores,n);
v2=zeros(cores,n);
%1st dimension
for i=1:cores
    v2(i,:)=vector(1+n*(i-1):n*i);
end
parfor i=1:cores
    v1(i,:)=bifilt1_c(v2(i,:),W,sigma);
end
for i=1:cores
    vectorf(1+n*(i-1):n*i)=v1(i,:);
end
result=reshape(vectorf,size(Mn));
waitbar(0.33,pb,'Processing...');
%2nd dimension
result=permute(result,[2 1 3]);
vector=result(:);
vector=vector';
for i=1:cores
    v2(i,:)=vector(1+n*(i-1):n*i);
end
parfor i=1:cores
    v1(i,:)=bifilt1_c(v2(i,:),W,sigma);
end
for i=1:cores
    vectorf(1+n*(i-1):n*i)=v1(i,:);
end
result=reshape(vectorf,size(result));
result=permute(result,[2 1 3]);
waitbar(0.66,pb,'Working...');
%3rd dimension
result=permute(result,[1 3 2]);
vector=result(:);
vector=vector';
for i=1:cores
    v2(i,:)=vector(1+n*(i-1):n*i);
end
parfor i=1:cores
    v1(i,:)=bifilt1_c(v2(i,:),W,sigmaZ);
end
for i=1:cores
    vectorf(1+n*(i-1):n*i)=v1(i,:);
end
result=reshape(vectorf,size(result));
result=permute(result,[1 3 2]);
waitbar(0.95,pb,'Just a moment');
out=round(result);
if ~Flagg
    delete(parell);
end
close(pb);
toc
end