clc
clear

a=[2
2
3
2
2
2
3
1
3
2
1
1
2
2
1
3
3
3
1
2
1
3
2
2
2
2
2
2
3
3
2
3
3
3
1
2
2
3
2
2
3
1
2
2
2
3
1
2
1
2
]


b=[2
3
2
3
1
2
2
2
2
3
3
3
3
1
3
2
3
1
1
1
3
2
2
1
2
2
3
2
2
1
3
1
1
2
2
3
3
1
1
3
2
2
2
2
2
3
2
1
3
2
]
c=zeros(50,1);

for i=1:50
    if a(i)==1
        if b(i)==1
            c(i)=1;
        elseif b(i)==2
            c(i)=2;
        else
            c(i)=3;
        end
    elseif a(i)==2
        if b(i)==1
            c(i)=4;
        elseif b(i)==2
            c(i)=5;
        else
            c(i)=6;
        end 
    else
        if b(i)==1
            c(i)=7;
        elseif b(i)==2
            c(i)=8;
        else
            c(i)=9;
        end
    end
end
c