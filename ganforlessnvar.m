
function [permbest,fitbest]=ganforlessnvar(perm,npop,ngrps)
%% paramters setting
% This function is for when the number of remaining arrays are less than
% group numbers.


%number of groups
ncomp=3; %input('number of components?');
%grups of component A,B and C
%A=[9 50 175 375 256 135]; %input('enter groups of component A in a row');
% B=[9 50 175 375 256 135]; %input('enter groups of component B in a row');
% C=[9 50 175 375 256 135];%input('enter groups of component C in a row');



% perm(1,:)=[8 2 3 4 5 6 7 8 9];
% perm(2,:)=[1 2 3 4 5 6 7 8 9];
% perm(3,:)=[5 5 3 5 5 5 7 8 5];

ngrp=size(perm(1,:)); % number of groups
nvar=ngrp(2);
     % number of population

maxiter=300;      % max of iteration


pc=0.6;                  % percent of crossover
ncross=2.*round(npop*pc/2);   % number of cross over offspring

pm=.1;                 % percent of mutation
%nmut=round(npop*pm);     % number of mutation offsprig

% perm=[5     5     3     5     5     5;     3     3     3     4     3     3;     4     4     3     4     4     4];


%% initialization
tic
empty.par=[];
empty.fit=[];
empty.rank=[];
empty.cdis=[];
pop=repmat(empty,npop,1);


for i=1:npop
    
   pop(i).par=[randperm(nvar) randperm(nvar) randperm(nvar)];
   counter1=zeros(1,ngrps);
   
       
   for s=1:nvar
         l=perm(1,s);
         counter1(l)=counter1(l)+1;
         
   end
   if ngrps>nvar
       for iii=nvar+1:ngrps
           if counter1(iii)>0
               counter1(iii)=counter1(iii)+1;
           end
       end
   end
   counter2=zeros(1,ngrps);
   for s=1:nvar
         l=perm(2,s);
         counter2(l)=counter2(l)+1;
   end
   if ngrps>nvar
       for iii=nvar+1:ngrps
           if counter2(iii)>0
               counter2(iii)=counter2(iii)+1;
           end
       end
   end
   counter3=zeros(1,ngrps);
   for s=1:nvar
         l=perm(3,s);
         counter3(l)=counter3(l)+1;
   end
   if ngrps>nvar
       for iii=nvar+1:ngrps
           if counter3(iii)>0
               counter3(iii)=counter3(iii)+1;
           end
       end
   end
   for j=1:nvar*ncomp
        
       if j<=nvar
               counterperm=zeros(1,max(perm(:)));
               counterpop=zeros(1,max(perm(:)));
           for s=1:nvar
               l=perm(1,s);
               counterperm(l)=counterperm(l)+1;
               h=pop(i).par(s);
               counterpop(h)=counterpop(h)+1;
           end
       if ismember( pop(i).par(j),perm(1,:))==0 || counterperm(pop(i).par(j))-counterpop(pop(i).par(j))<0
           
        
         
         avali=find(counter1>1,1);
         pop(i).par(j)=avali;
         counter1(avali)=counter1(avali)-1;
       end

       elseif j<=2*nvar
           counterperm=zeros(1,max(perm(:)));
               counterpop=zeros(1,max(perm(:)));
           for s=1:nvar
               l=perm(2,s);
               counterperm(l)=counterperm(l)+1;
               h=pop(i).par(s+nvar);
               counterpop(h)=counterpop(h)+1;
           end
       if ismember( pop(i).par(j),perm(2,:))==0 || counterperm(pop(i).par(j))-counterpop(pop(i).par(j))<0
         
         
         avali=find(counter2>1,1);
         pop(i).par(j)=avali;
         counter2(avali)=counter2(avali)-1;
       end        
          
       else
           counterperm=zeros(1,max(perm(:)));
               counterpop=zeros(1,max(perm(:)));
           for s=1:nvar
               l=perm(3,s);
               counterperm(l)=counterperm(l)+1;
               h=pop(i).par(s+2.*nvar);
               counterpop(h)=counterpop(h)+1;
           end
        if ismember( pop(i).par(j),perm(3,:))==0 || counterperm(pop(i).par(j))-counterpop(pop(i).par(j))<0
         
         
         avali=find(counter3>1,1);
         pop(i).par(j)=avali;
         counter3(avali)=counter3(avali)-1;
       end
       end 
   end
   

   [pop(i).fit]=fitness(pop(i).par,nvar);
end
[pop,F]=non_dominated_sorting(pop);
pop=crowding_distance(pop,F);
pop=sorting(pop);


%% main loop

BEST=zeros(maxiter,3);


for iter=1:maxiter


   % crossover
   
   crosspop=repmat(empty,ncross,1);
   crosspop=crossovern(crosspop,pop,nvar,ncross);
   
   
   % mutation (only for children)
   crosspopmutated=mutation(crosspop,nvar,ncross, pm);
%    crosspopmutated1=crosspopmutated';
   
   % merged
  [pop]=[pop;crosspopmutated];
  
  [pop,F]=non_dominated_sorting(pop);
  pop=crowding_distance(pop,F);
  pop=sorting(pop);


  % selects
  pop=pop(1:npop);

  [pop,F]=non_dominated_sorting(pop);
  pop=crowding_distance(pop,F);
  pop=sorting(pop);
  
  
  gpop=pop(1);   % global pop
  
  C=[pop.fit]';
  figure(1)
%    plotpareto(F,C)
%    hold on
% D=zeros(npop,27);
[D]={pop(F{1}).par};
nf=length(F{1});
V=zeros(nf,15);
for t=1:nf
    V(t,:)=D{t};
end
% D1=D(F{1},:);
  C1=C(F{1},:);

% plot3(C1(:,1), C1(:,2), C1(:,3), 'r*')
scatter3(C1(:,1), C1(:,2), C1(:,3))
xlabel('F1')
ylabel('F2')
zlabel('F3')


  disp(['iter= ' num2str(iter) ' Pareto ' num2str(length(F{1}))])

 BEST(iter,:)=[gpop.fit];


%  disp([ ' Iter = '  num2str(iter)  ' BEST = '  num2str(BEST(iter))]);


  if iter>100 && BEST(iter,1)-BEST(iter-100,1)<0.01 && BEST(iter,2)-BEST(iter-100,2)<0.01 && BEST(iter,3)-BEST(iter-100,3)<0.01
      break
  end

end
%% results
permbest=V;
[fitbest]=C1;


% disp(' ')
% disp([ ' Best par = '  num2str(gpop.par)])
% disp([ ' Best fitness = '  num2str(gpop.fit)])
% disp([ ' Time = '  num2str(toc)])

toc

end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                   %
%                       Abolfazl Rezaei Aderiani                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


