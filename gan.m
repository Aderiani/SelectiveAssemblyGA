
function [permbest,fitbest]=gan(perm,tol,npop)
%% paramters setting
%number of groups
ncomp=3; %input('number of components?');
%grups of component A,B and C
%A=[9 50 175 375 256 135]; %input('enter groups of component A in a row');
% B=[9 50 175 375 256 135]; %input('enter groups of component B in a row');
% C=[9 50 175 375 256 135];%input('enter groups of component C in a row');

ngrp=size(perm(1,:)); % number of groups
nvar=ngrp(2);



% npop=input('Population size?');         % number of population

maxiter=1000;      % max of iteration


pc=0.6;                  % percent of crossover
ncross=2.*round(npop*pc/2);   % number of cross over offspring

pm=.08;                 % percent of mutation
%nmut=round(npop*pm);     % number of mutation offsprig

% perm=[5     5     3     5     5     5;     3     3     3     4     3     3;     4     4     3     4     4     4];


%% initialization
tic
empty.par=[];
empty.fit=[];


pop=repmat(empty,npop,1);


for i=1:npop
    
    pop(i).par=[randperm(nvar) randperm(nvar)];
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
%     counter3=zeros(1,nvar);
%     for s=1:nvar
%         l=perm(3,s);
%         counter3(l)=counter3(l)+1;
%     end
    
    for j=1:nvar*ncomp
        
        if j<=nvar
            counterperm=zeros(1,nvar);
            counterpop=zeros(1,nvar);
            for s=1:nvar
                l=perm(1,s);
                counterperm(l)=counterperm(l)+1;
                h=pop(i).par(s);
                counterpop(h)=counterpop(h)+1;
            end
            if ismember( pop(i).par(j),perm(1,:))==0 || counterperm(pop(i).par(j))-counterpop(pop(i).par(j))<0
                
                
                
                avali=find(counter1>1,1,'first');
                pop(i).par(j)=avali;
                counter1(avali)=counter1(avali)-1;
            end
            
        elseif j<=2*nvar
            counterperm=zeros(1,nvar);
            counterpop=zeros(1,nvar);
            for s=1:nvar
                l=perm(2,s);
                counterperm(l)=counterperm(l)+1;
                h=pop(i).par(s+nvar);
                counterpop(h)=counterpop(h)+1;
            end
            if ismember( pop(i).par(j),perm(2,:))==0 || counterperm(pop(i).par(j))-counterpop(pop(i).par(j))<0
                
                
                avali=find(counter2>1,1,'first');
                pop(i).par(j)=avali;
                counter2(avali)=counter2(avali)-1;
            end
        end
    end
    
    
    pop(i).fit=fitness(pop(i).par,tol,nvar);
end



%% main loop

BEST=zeros(maxiter,1);
MEAN=zeros(maxiter,1);

for iter=1:maxiter
    
    
    % crossover
    
    crosspop=repmat(empty,ncross,1);
    crosspop=crossovern(crosspop,pop,nvar,ncross);
    
    
    % mutation (only for children)
    crosspopmutated=mutation(crosspop,nvar,ncross, pm,tol);
    %    crosspopmutated1=crosspopmutated';
    
    % merged
    [pop]=[pop;crosspopmutated];
    
    
    % selects
    [~,index]=sort([pop.fit],'descend');
    pop=pop(index);
    pop=pop(1:npop);
    
    gpop=pop(1);   % global pop
    
    
    
    BEST(iter)=-(log(gpop.fit))./.05;
    MEAN(iter)=-(log(mean([pop.fit]))./.05);
    
    
    
    %  disp([ ' Iter = '  num2str(iter)  ' BEST = '  num2str(BEST(iter))]);
    
    
    if iter>100 && BEST(iter)==BEST(iter-100)
        break
    end
    
end
%% results
permbest=gpop.par;
fitbest=-(log(gpop.fit))./.05;

% disp(' ')
% disp([ ' Best par = '  num2str(gpop.par)])
% disp([ ' Best fitness = '  num2str(gpop.fit)])
% disp([ ' Time = '  num2str(toc)])



figure(1)
plot(BEST(1:iter),'r','LineWidth',2)
hold on
plot(MEAN(1:iter),'b','LineWidth',2)


xlabel('Iteration')
ylabel(' Fitness')

legend('BEST','MEAN')


title('GA for Selective Assembly')
end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                   %
%                       Abolfazl Rezaei Aderiani                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


