function out=FBM_alternativo(a,N,W,sigmaL,sigmaH,sigmaZ,Flagg)
    %Example 
    %out=FBM_alternativo(volumen1,11,5,[0.2 0.5],[0.2 0.5],[0.2 0.5],1);
    % Flagg 0 enecender procesamiento en paralelo 1 no hacer nada
    % cores número de procesadores (2-12)
    
    lp_image=zeros(size(a));
    hp_image=zeros(size(a));
    pb = waitbar(0,'1','Name','Procesando filtro binomial');
    
    for i=1:size(a,3)
      waitbar(i/size(a,3),pb,'Realizando filtrado binomial');  
      [lp_image(:,:,i),hp_image(:,:,i)]=binomf(a(:,:,i),N);
    end
    close(pb);
    
    out1=bilateral3D_alternativo(lp_image,W,sigmaL,sigmaZ,Flagg);
    out2=bilateral3D_alternativo(hp_image,W,sigmaH,sigmaZ,Flagg);
    out=out1+out2;
    
    
    %NORMALIZATION
    out=out-min(out(:));
    out=out/max(out(:));
    out=out*(max(a(:))-min(a(:)));
    out=out+min(a(:));
    
    %out=out+abs(min(a(:)));
end