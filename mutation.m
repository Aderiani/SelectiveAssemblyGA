function  crosspopmutated=mutation(crosspop,nvar,ncross, pm,tol)




for n=1:ncross
    for j=1:nvar-1
        if rand<=pm
            j1=crosspop(n).par(j);
            j2=crosspop(n).par(j+1);
            crosspop(n).par(j)=j2;
            crosspop(n).par(j+1)=j1;
        end
    end
    for j=1:nvar-1
        if rand<=pm
            j1=crosspop(n).par(j+nvar);
            j2=crosspop(n).par(j+nvar+1);
            crosspop(n).par(j+nvar)=j2;
            crosspop(n).par(j+nvar+1)=j1;
        end
    end
end
crosspopmutated=crosspop;

for i=1:ncross
crosspopmutated(i).fit=fitness(crosspop(i).par,tol,nvar);
end

end
        




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                   %
%                          www.matlabnet.ir                         %
%                   Free Download  matlab code and movie            %
%                          Shahab Poursafary                        %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
