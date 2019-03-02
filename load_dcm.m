function  [M,info]=load_dcm(directorio)
% LOAD_DCM is a function that receives as input a folder with .dcm files
% they are loaded an stored in a 3-dim matrix (width x hight x slices)
%
% Jorge Mario Guerra 2019
    h= dir(directorio);
    nombre=h(3).name;
    map=dicomread(strcat(directorio,'/',nombre));
    info=dicominfo(strcat(directorio,'/',nombre));
    M=zeros(size(map,1),size(map,2),length(h));
    M(:,:,1)=map;
    pb = waitbar(0,'Loading');
    if (length(h)>3)
        for i=4:length(h)
            perc=i/length(h);
            waitbar(perc,pb,strcat(int2str(perc*100),'% Loading'));
            nombre=h(i).name;
            map=dicomread(strcat(directorio,'/',nombre));
            info2=dicominfo(strcat(directorio,'/',nombre));
            M(:,:,i-2)=map;
            info=[info;info2]; %#ok<*AGROW>
        end
    end
    M=M-1024;
    close(pb);
end
