function  [fit]=fitness(x,tol,nvar)


c_max=zeros(1,nvar);
c_min=zeros(1,nvar);


for i=1:nvar
    
   c_max(i)=tol(1).*x(i)+tol(2).*x(i+nvar);
   c_min(i)=tol(1).*(x(i)-1)+tol(2).*(x(i+nvar)-1);
   
end

cmin=min(c_min);
cmax=max(c_max);
z=cmax-cmin;
fit=exp(-1.*.05.*z);






end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                   %
%                          Abolfazl Rezaei Aderiani                 %
%                                                                   %
%                                                                   %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%