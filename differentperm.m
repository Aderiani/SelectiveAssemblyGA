clc
clear
empty.par=[];
empty.fit=[];
npop=5;
ncomp=3;
pop=repmat(empty,npop,1);
nvar=6;

perm(1,:)=[5 5 3 5 5 5];
perm(2,:)=[3 3 3 4 3 3];
perm(3,:)=[4 4 3 4 4 4];
for i=1:npop
    
   pop(i).par=[randperm(nvar) randperm(nvar) randperm(nvar)];
   counter1=zeros(1,nvar);
   for s=1:nvar
         l=perm(1,s);
         counter1(l)=counter1(l)+1;
   end
   counter2=zeros(1,nvar);
   for s=1:nvar
         l=perm(2,s);
         counter2(l)=counter2(l)+1;
   end
   counter3=zeros(1,nvar);
   for s=1:nvar
         l=perm(3,s);
         counter3(l)=counter3(l)+1;
   end
   
   for j=1:nvar.*ncomp
        
       if j<=nvar
               counterperm=zeros(1,nvar);
               counterpop=zeros(1,nvar);
           for s=1:nvar
               l=perm(1,s);
               counterperm(l)=counterperm(l)+1;
               h=pop(i).par(s);
               counterpop(h)=counterpop(h)+1;
           end
       if ismember( pop(i).par(j),perm(1,:))==0 | counterperm(pop(i).par(j))-counterpop(pop(i).par(j))<0
           
        
         
         avali=find(counter1>1,1,'first');
         pop(i).par(j)=avali;
         counter1(avali)=counter1(avali)-1;
       end

       elseif j<=2.*nvar
           counterperm=zeros(1,nvar);
               counterpop=zeros(1,nvar);
           for s=1:nvar
               l=perm(2,s);
               counterperm(l)=counterperm(l)+1;
               h=pop(i).par(s+nvar);
               counterpop(h)=counterpop(h)+1;
           end
       if ismember( pop(i).par(j),perm(2,:))==0 | counterperm(pop(i).par(j))-counterpop(pop(i).par(j))<0
         
         
         avali=find(counter2>1,1,'first');
         pop(i).par(j)=avali;
         counter2(avali)=counter2(avali)-1;
       end        
          
       else
           counterperm=zeros(1,nvar);
               counterpop=zeros(1,nvar);
           for s=1:nvar
               l=perm(3,s);
               counterperm(l)=counterperm(l)+1;
               h=pop(i).par(s+2.*nvar);
               counterpop(h)=counterpop(h)+1;
           end
        if ismember( pop(i).par(j),perm(3,:))==0 | counterperm(pop(i).par(j))-counterpop(pop(i).par(j))<0
         
         
         avali=find(counter3>1,1,'first');
         pop(i).par(j)=avali;
         counter3(avali)=counter3(avali)-1;
       end
       end 
   end
   pop(i).par
end