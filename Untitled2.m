clc
clear

p=[1     3     2     4     5     6     3     6     4     1     5     2     6     2     4     5     1     3
4     6     5     4     2     3     6     4     1     3     2     5     1     2     5     4     6     3
2     5     6     4     4     3     2     3     5     6     4     3     6     4     1     2     3     5
6     2     3     5     4     4     3     3     4     5     2     3     3     6     4     2     5     4
4     6     2     4     3     5     3     3     3     2     4     5     4     3     6     5     4     2
5     4     6     4     4     3     4     3     5     3     3     2     3     5     2     4     4     6
4     4     6     3     5     4     4     3     2     3     3     5     4     5     4     6     4     3
3     4     4     4     5     6     5     3     4     4     4     2     4     5     4     4     3     4
5     3     5     6     4     5     3     3     2     3     4     3     5     5     5     3     4     5
5     3     6     4     5     5     4     3     3     3     3     3     3     5     4     5     5     5
4     4     5     4     4     3     4     4     4     4     4     3     3     3     3     4     3     5
4     3     5     5     5     5     3     4     3     3     3     3     4     4     3     4     4     4
5     5     5     5     5     3     3     3     3     3     3     4     4     4     4     4     3     4]

tol=[2 2.5 3];
nvar=6;
[fmax fmin]=fitnessnn(p(1,:),tol,nvar);
for i=1:13
       [ffmax ffmin]=fitnessnn(p(i,:),tol,nvar);
       if ffmax>fmax
           fmax=ffmax;
       end
       if ffmin<fmin
           fmin=ffmin;
       end
end
fmax
fmin
    