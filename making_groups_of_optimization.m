clc
clear
%% the algorithm for making groups of optimization.

A(1,:)=[12 67 260 370 256 35]; %input('enter groups of component A in a row');
A(2,:)=[5 111 448 331 98 7];
nvar=6;
perm(1,:)=[1 2 3 4 5 6];
perm(2,:)=[1 2 3 4 5 6];
npop=50;
tol=[2 3];
perm
A
[permbest,fitbest]=gan(perm,tol,npop)
for i=1:19
    
        [value, index]=min(A(:));
        [I_row, I_col] = ind2sub(size(A),index);
        A=A-value; 
        k=1;
        for s=1:2
        if I_row==s
            [value2, index2]=max(A(s,:));
            for j=1:nvar
                if A(s,j)==0
                    k=k+1;
                end 
            end
           
            A(s,index2)=value2-(k-1).*round(value2./k);
            for j=1:nvar
                if A(s,j)==0
                    A(s,j)=round(value2./k);
                    perm(s,j)=perm(s,index2);
                end 
            end
   
         end 
         end
       
        perm        
        A
        [permbest,fitbest]=gan(perm,tol,npop)
end
