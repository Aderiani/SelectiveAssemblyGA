function  [cmax cmin]=fitnessnn(x,tol,nvar)


z=0;

for i=1:nvar
    
   c_max(i)=tol(1).*x(i)+tol(2).*x(i+nvar);
   c_min(i)=tol(1).*(x(i)-1)+tol(2).*(x(i+nvar)-1);
   
end

cmin=min(c_min);
cmax=max(c_max);

