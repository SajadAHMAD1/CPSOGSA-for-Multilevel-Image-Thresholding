
%

                      
%              CPSOGSA for Multilevel Image Thresholding
% 


%   Programmer: Sajad Ahmad Rather      
%   Developed in MATLAB R2013a 

%               Department of Computer Science and Engineering
%               School of Engineering and Technology
%               Pondicherry University- 605014, India
%                  
%                 E-Mail: sajad.win8@gmail.com                   
%                                                                         
%              %              Homepage: https://github.com/SajadAHMAD1  
%                                       https://in.mathworks.com/matlabcentral/profile/authors/6240015-sajad-ahmad-rather                         
%                                                                         
    

%               






                              %-------------------------------------------%
                              %         Evaluate the population           %           
                              %-------------------------------------------%                                 %--%
 %%% Variables %%%

%current_position:  Position of particles
%velocity:          Velocity
%force:             The gravitational force between the particles
%acceleration:      Acceleration
%mass:              Mass 
%dim:               Dimension of test functions
%n:                 Number of particles
%G0                 Gravitational constant
%low:               The lower bound of the search space
%up:                The higher bound of the search space



 function [CPSOGSA_bestit,CPSOGSA_bestF,CPSOGSA_Fit_bests]= CPSOGSA(I, Lmax, n,iteration,low,up,dim, level, probR)

current_position = zeros(n,dim);

% % Constriction Coefficients
phi1=2.05;
phi2=2.05;
phi=phi1+phi2;
chi=2/(phi-2+sqrt(phi^2-4*phi));
w=chi;          % Inertia Weight
wdamp=1;        % Inertia Weight Damping Ratio
C1=chi*phi1;    % Personal Learning Coefficient
C2=chi*phi2;    % Global Learning Coefficient

current_fitness =zeros(n,1);
gBest=zeros(1,dim);
gBestScore=inf;
 

 for i=1:n
        pBestScore=inf;
 end
        pBest=zeros(n,dim);

G0=1;                  % gravitational constant
for i = 1:dim
    lambda = rand(n,1);
    current_position(:,i) = fix(low(i,1) + lambda * (up(i,1) - low(i,1)));
      current_position= sort(current_position);
      
end

iter = 0 ;                  % Iteration counter
while  ( iter < iteration )

G=G0*exp(-23*iter/iteration); 
iter = iter + 1;
iter;
velocity = .3*randn(n,dim) ;
force=zeros(n,dim);
mass(n)=0;
acceleration=zeros(n,dim);
 for i = 1:n
%      [n,dim]=size(current_position);
%     %///Bound the search Space///

%      Tp=current_position>up;
% %     
%      Tm=current_position<low;
%      current_position=(current_position .*(~(Tp+Tm)))+up.*Tp+low.*Tm; 
%     %%
%     [N,dim]=size(X);
% for i=1:n 
% Tp=X(i,:)>up;Tm=X(i,:)<low;X(i,:)=(X(i,:).*(~(Tp+Tm)))+up.*Tp+low.*Tm;
%     %%Agents that go out of the search space, are reinitialized randomly .
%     Tp=current_position(i,:)>up;Tm=current_position(i,:)<low;current_position(i,:)=(current_position(i,:).*(~(Tp+Tm)))+((rand(1,dim).*(up-low)+low).*(Tp+Tm));
    %%
    %////////////////////////////
    
                                 %-------------------------------------------%
                                 %         Evaluate the population           %           
                                 %-------------------------------------------% 
       fitness=0;
       fitness=Kapur(n,level,fix(current_position),probR);
       current_fitness=fitness;    
    if(pBestScore>fitness)
       pBestScore=fitness;
       pBest=current_fitness;
        
    end
    if(gBestScore>fitness)
       gBestScore=fitness;
       gBest=current_position;
    end
 end

 best=max(current_fitness);
 worst=min(current_fitness);

 GlobalBestCost=gBestScore;
 GlobalBestCost;
 best;
        
    for pp=1:n
        if current_fitness(pp)==best
            break;
        end
        
    end
    
    bestIndex=pp;
            
    for pp=1:dim
        best_fit_position(iter,1)=best;
        best_fit_position(iter,pp+1)=current_position(bestIndex,pp);   
    end
                                               %-------------------%
                                               %   Calculate Mass  %
                                               %-------------------%
    for i=1:n
    mass(i)=(current_fitness(i)-0.99*worst)/(best-worst);    
    end

    for i=1:n
    mass(i)=mass(i)*5/sum(mass);      
    end

                                               %-------------------%
                                               %  Force    update  %
                                               %-------------------%

for i=1:n
    for j=1:dim
        for k=1:n
            if(current_position(k,j)~=current_position(i,j))
                % Equation (3)
                 force(i,j)=force(i,j)+ rand()*G*mass(k)*mass(i)*(current_position(k,j)-current_position(i,j))/abs(current_position(k,j)-current_position(i,j));
                
            end
        end
    end
end
                                               %------------------------------------%
                                               %  Accelations $ Velocities  UPDATE  %
                                               %------------------------------------%

for i=1:n
       for j=1:dim
            if(mass(i)~=0)
                %Equation (6)
                acceleration(i,j)=force(i,j)/mass(i);
            end
       end
end   


for i=1:n
        for j=1:dim
            %Equation(9)
            velocity(i,j)=w*rand()*velocity(i,j)+C1*rand()*acceleration(i,j) + C2*rand()*(gBest(j)-current_position(i,j));

        end

end
                                               %--------------------------%
                                               %   positions   UPDATE     %
                                               %--------------------------%

current_position = current_position + velocity ;
current_position = max(current_position,low);
current_position = min(current_position,up);

w=w*wdamp;

% Show Iteration Information
    [mm,ii] = max(current_fitness); %maximiza
    CPSOGSA_Fit_bests(iter) = mm; %Major Fitness
    CPSOGSA_elem(iter,:) = current_position(ii,1:dim-1); 
    CPSOGSA_bestit = fix(current_position(ii,1:dim-1)); 
    CPSOGSA_bestF = mm; 
   
   if iter == 1  || CPSOGSA_bestF > CPSOGSA_ant
        CPSOGSA_ant= CPSOGSA_bestF;
        cc = 0;
   elseif CPSOGSA_bestF == CPSOGSA_ant
        cc = cc + 1;
   end
   
   if cc > (iteration * 0.10)
       break;
   end
end