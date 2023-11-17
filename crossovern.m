function    crosspop=crossovern(crosspop,pop,nvar,ncross)

% rolet wheel:
f=[pop.fit];
f=f./sum(f);
f=cumsum(f);


for n=1:ncross
     
    
    i1=find(rand<=f,1,'first');  % selection of the first parent based on the rolet wheel
  
    
    


lcross=randi(nvar-1);
gp1=pop(i1).par(1:lcross);
gp2=pop(i1).par(lcross+1:nvar);

lcross2=randi(nvar-1)+nvar;
gp3=pop(i1).par(nvar+1:lcross2);
gp4=pop(i1).par(lcross2+1:2*nvar);

% lcross3=randi(nvar-1)+2.*nvar;
% gp5=[pop(i1).par(2.*nvar+1:lcross3)];
% gp6=[pop(i1).par(lcross3+1:3.*nvar)];
%childern configaration
o1=[gp2 gp1 gp4 gp3];
crosspop(n).par=o1;
% crosspop(n).fit=fitness(crosspop(n).par,tol,nvar);
end





