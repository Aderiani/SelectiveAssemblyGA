clear
clc
a=[3
2
6
3
6
4
1
4
1
4
4
2
4
4
6
2
3
4
2
3
1
1
5
3
5
4
1
3
1
2
4
4
4
3
4
2
2
4
3
2
4
2
2
5
3
3
2
4
3
2
];


x=zeros(6,1);

for i=1:50
    if a(i)==1 
        x(1)=x(1)+1;
    elseif a(i)==2 
         x(2)=x(2)+1;
    elseif a(i)==3 
         x(3)=x(3)+1;
    elseif a(i)==4 
         x(4)=x(4)+1;
    elseif a(i)==5
         x(5)=x(5)+1;
    elseif a(i)==6 
         x(6)=x(6)+1;
    end
end
   
        
x
