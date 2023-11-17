function dis=cal_dis(postmat)

nvar=size(postmat,1);
dis=zeros(nvar,nvar);
for i=1:nvar-1
    for j=i+1:nvar
        
        dis(i,j)=norm(postmat(i,:)-postmat(j,:));
        dis(j,i)=dis(i,j);
    end
end
end

        
      
        