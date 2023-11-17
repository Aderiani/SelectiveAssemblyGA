clc
clear

p=[2 4 5 1 3 6  5 4 2 6 3 1
1 6 2 5 3 4  6 2 5 3 4 3 
4 2 3 1 6 5  3 4 3 5 2 3
4 6 3 4 2 5 3 2 4 3 5 3
4 3 2 5 4 4 3 4 5 2 3 3
4     4     4     5     4     3     3     4     4     2     4     5
3 3 5 3 4 3 4 3 2 3 3 3]

tol=[2 3];
nvar=6;
[fmax fmin]=fitnessnn(p(1,:),tol,nvar);
for i=1:7
       [ffmax ffmin]=fitnessnn(p(i,:),tol,nvar)
       i
end
