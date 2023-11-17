clc
clear
%% initialization.

A(1,:)=[12 67 260 370 256 35]; %input('enter groups of component A in a row');
A(2,:)=[5 111 448 331 98 7];
nvar=6;
perm(1,:)=[1 2 3 4 5 6];
perm(2,:)=[1 2 3 4 5 6];
%%
% 
%   for x = 1:10
%       disp(x)
%   end
% 

ncomp=2;

tol=[2 3];

npop=input('Population size?');
perm        
A

empty.par=[];
empty.fit=[];


permb=repmat(empty,20,1);

[permbest, fitness]=gan(perm,tol,npop)
%% main loop
i=1;
while i<17
    
        [value, index]=sort(A(:));
        [I_row, I_col] = ind2sub(size(A),index(i));
        A=A-value(i); 
        k=1;
        for s=1:2
            k=1;
            [value2, index2]=max(A(s,:));
            
            for j=1:nvar
                if A(s,j)==0
                    k=k+1;
                   
                end 
            end
            if value2-(k-1)*A(index(i+1))<0 || A(index(i+1))<0
                i=100;
               break
            end
           
            A(s,index2)=value2-(k-1).*A(index(i+1));
        
            for j=1:nvar
                if A(s,j)==0
                    A(s,j)=A(index(i+1));
                    perm(s,j)=perm(s,index2);
                    
                end 
            end
       
         end 
        i=i+1;
       
        perm        
        A
        [permbest, fitness]=gan(perm,tol,npop)
end
