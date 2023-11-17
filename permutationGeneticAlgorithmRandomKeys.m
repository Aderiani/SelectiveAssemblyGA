clear all; close all; clc;

%%  Nomenclature
%uppercase first letter means vector or matrix. Lowercase means scalar.

%Genetic Algorithm parameters
%max number of generations
gens = 15;

%Number of initial configurations
firstGenSize = 100;
%generation size
genSize = 50;

%mutation propability
mutProb = 0.05;
%Vanes
vanes = 11;

%first_last used for crossover
FirstOrLast = {'first'; 'last'};

%Configuration matrix M. This contains all configurations we've tried so
%far?

%% New thing: I've made all the vectors three-dimensional. The first column of the thrid dimension is the permutation, the second is the random keys
%M_keysXXXXXX = zeros(firstGenSize,vanes);
M = zeros(firstGenSize,vanes,2);
%% 
%Simulation results vector Results
Results = zeros(firstGenSize,1);

%placeholder simulation. This function will generate the highest value for
%configuration [1,2,3,4,5,6,7,8,9,10,11]
PlaceholderSimulation = 1:vanes;
sim = @(X) X*PlaceholderSimulation';

%initialize configuration matrix with random values
%generating results for initial generation

for i = 1:firstGenSize
    M(i,:,2) = rand(1,vanes);
    % this sort operation converts the keys to a permutation
    [ignore,M(i,:,1)] = sort(M(i,:,2));
    
    Results(i) = sim(M(i,:,1));
end

%% Start of Genetic Algorithm


for i = 1:gens
    
    % 1st step: Parents selection
    %getting the indexes of the highest results
    [ResultsSortedValues, ResultsSortedIndex] = sort(Results,1,'descend');
    %randomizing the 50 highest results, combining them into children
    TopResultsSortedIndex = ResultsSortedIndex(1:genSize);
    TopResultsSortedValues = ResultsSortedValues(1:genSize);
    
    % Extracting the configurations that performed well as parents
    Parents = M(TopResultsSortedIndex,:,:);
    
    % Initializing children configuration vector
    Children = zeros(size(Parents));
    % Initializing temp variables used for each family of two parents and two children
    TempParent = zeros(2,vanes,2);
    TempChild = zeros(2,vanes,2);
    
    for j = 1:2:genSize
        
        %% Roulette wheel parents selection
        %The odds of a parents breeding success is determined by its
        %relative rank amongst the top 50 parents. Here, a roulette board
        %is devised where the probability of of breeding is a function of
        %how much better they are compared to the 50th entry. Here, the
        %50th entry gets no probability of breeding at all.
        
        % the worst of the top 50
        TopMin = min(TopResultsSortedValues);
        
        % Transposing the top values against the min
        TopTransposedAgainstMin = TopResultsSortedValues-TopMin;
        
        %building a cumulative roulettewheel. This is a cumulative
        %distribution function with a max value of one
        RouletteWheel = cumsum(TopTransposedAgainstMin)/sum(TopTransposedAgainstMin);
        
        %% Now let's spin the wheel twice to find the parents
        k = 1;
        while k
            
            % here we spin the wheel by drawing a uniform random number between 0 annd 1, and
            % substracting it from the cumulative distribution function. We
            % use the absolute value of this, so that the minimum value
            % equals where the ball stopped
            SpinningTheWheel = abs(RouletteWheel-rand);
            
            % here we extract the index of the minimum value. We are not
            % interested in the value, so we use an ignore variable
            [ignore, indexParent] = min(SpinningTheWheel);
            
            % we find the parent corrensponting to the index
            TempParent(k,:,:) = Parents(indexParent,:,:);
            
            % this is a way to avoid duplicate parents
            if k == 1
                k = 2;
            else
                if TempParent(k,:,1) == TempParent(k-1,:,1)
                    
                else
                    break
                end
            end
            
        end
        
        
        %% Crossover
        %crossover element. This gives the index of the element where the
        %parent vectors will split
        crossoverElement = randi(11);
        
        for k = 1:2
            
            % we need to check each child against all previous children in
            % to avoid running the same simulation twice
            
            duplicateChildrenCheckerClear = 0;
            while duplicateChildrenCheckerClear < 1
                
                
                TempChild(k,:,:) = [TempParent(k,1:crossoverElement,:) TempParent(3-k,(crossoverElement+1):11,:)];
                
                
                
                %% Mutation
                % with a certain probability mutProb, the two elements a
                % and b will change in the child vector
                if rand < mutProb
                    a = randi(11);
                    b = randi(11);
                    TempChild(k,[a b],:) = TempChild(k,[b a],:);
                end
                
                % i dont know what this pause is for
                
                pause(0);
                
                
                % the duplicate vector works by checking if the Tempchild
                % is a member of either M (configurations from previous
                % generations) or children (configurations from current
                % generations
                [ignore,TempChild(k,:,1)] = sort(TempChild(k,:,2));
                
                dupl = sum(ismember(M(:,:,1), TempChild(k,:,1),'rows')) + sum(ismember(Children(:,:,1), TempChild(k,:,1),'rows'));
                
                
                if dupl == 0
                    duplicateChildrenCheckerClear = 1;
                else
                    crossoverElement = randi(11);
%                     TempChild(k,:,2) = rand(1,11);
%                     [ignore,TempChild(k,:,1)] = sort(TempChild(k,:,2));
%                     dupl = sum(ismember(M(:,:,1), TempChild(k,:,1),'rows')) + sum(ismember(Children(:,:,1), TempChild(k,:,1),'rows'));
%                     if dupl == 0
%                     duplicateChildrenCheckerClear = 1;
%                     end
                end
                
                % when duplicate checker is cleared, the child is added to
                % the Children matrix
                %Children_keys(j-1+k,:) = TempChild(k,:);
                Children(j-1+k,:,:) = TempChild(k,:,:);
            end
        end
    end
    
    % growing inside a loop, I know!
    m_old_length = length(M);
    M = [M;Children];
    m_new_length = length(M);
    for k = m_old_length:m_new_length
        
        Results(k) = sim(M(k,:,1));
        
    end
end

plot(Results)
max(Results)
