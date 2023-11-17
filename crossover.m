function    crosspop=crossover(crosspop,pop,nvar,ncross,tol)

% rolet wheel:
f=[pop.fit];
f=f./sum(f);
f=cumsum(f);


for n=1:2:ncross
     
    
    i1=find(rand<=f,1,'first');  % selection of the first parent based on the rolet wheel
    i2=find(rand<=f,1,'first');  % selecyion of the second parent based on the rolet wheel
    
    
p1=pop(i1).par;
p2=pop(i2).par;

%creat random numbers equal to parents.
% random for parent 1
child1rand1=rand(1,nvar);
m=sort(child1rand1);
for i=1:nvar
    l=find(i==p1,1);
    child1sorted(l)=m(i);
end
child1rand2=rand(1,nvar);
c=sort(child1rand2);
for i=1:nvar
    s=find(i==p1(nvar+1:2.*nvar),1);
    child1sorted(s+nvar)=c(i);
end
child1rand3=rand(1,nvar);
h=sort(child1rand3);
for i=1:nvar
    k=find(i==p1(2.*nvar+1:end),1);
    child1sorted(k+2.*nvar)=h(i);
end



%random for parent 2
child2rand1=rand(1,nvar);
m=sort(child2rand1);
for i=1:nvar
    l=find(i==p2,1);
    child2sorted(l)=m(i);
end
child2rand2=rand(1,nvar);
c=sort(child2rand2);
for i=1:nvar
    hj=find(i==p2(nvar+1:2.*nvar),1);
    child2sorted(hj+nvar)=c(i);
end
child2rand3=rand(1,nvar);
h=sort(child2rand3);
for i=1:nvar
    k=find(i==p2(2.*nvar+1:end),1);
    child2sorted(k+2.*nvar)=h(i);
end

%creating offsprings

for i=1:nvar
   
j=randi([1 nvar-1]);
g=randi([nvar 2.*nvar-1]);
t=randi([2.*nvar 3.*nvar-1]);

o1=[child1sorted(1:j) child2sorted(j+1:nvar) child1sorted(nvar+1:g) child2sorted(g+1:2.*nvar) child1sorted(2.*nvar+1:t) child2sorted(t+1:end)];
o2=[child2sorted(1:j) child1sorted(j+1:nvar) child2sorted(nvar+1:g) child1sorted(g+1:2.*nvar) child2sorted(2.*nvar+1:t) child1sorted(t+1:end)];

[yadola, poppar]=sort(o1(1:nvar));
[yadola, poppar(nvar+1:2.*nvar)]=sort(o1(nvar+1:2.*nvar));
[yadola, poppar(2.*nvar+1:3.*nvar)]=sort(o1(2.*nvar+1:3.*nvar));

crosspop(n).par=poppar;
crosspop(n).fit=fitness(crosspop(n).par,tol,nvar);

[yadola, poppar2]=sort(o2(1:nvar));
[yadola, poppar2(nvar+1:2.*nvar)]=sort(o2(nvar+1:2.*nvar));
[yadola, poppar2(2.*nvar+1:3.*nvar)]=sort(o2(2.*nvar+1:3.*nvar));
crosspop(n+1).par=poppar2;
crosspop(n+1).fit=fitness(crosspop(n+1).par,tol,nvar);

end

end



