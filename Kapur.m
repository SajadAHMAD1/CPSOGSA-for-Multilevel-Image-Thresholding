                      
%              CPSOGSA for Multilevel Image Thresholding
% 


%Publication: Rather, S. A., & Bala, P. S. (2021). Constriction Coefficient Based Particle Swarm Optimization and Gravitational Search Algorithm for Multilevel Image Thresholding. Expert Systems, doi: 10.1111/exsy.12717, Wiley, SCIE (I.F = 1.546)%% 

%   Programmer: Sajad Ahmad Rather      
%   Developed in MATLAB R2016a 

%               Department of Computer Science and Engineering
%               School of Engineering and Technology
%               Pondicherry University- 605014, India
%                  
%                 E-Mail: sajad.win8@gmail.com                   
%                                                                         
%              Homepage: https://github.com/SajadAHMAD1  
%                        https://in.mathworks.com/matlabcentral/profile/authors/6240015-sajad-ahmad-rather
%   

function fitR = Kapur(m,level,xR,PI)

%Kapurs Entropy Method
fitR = zeros(1,m);
for j = 1: m
    PI0 = PI(1:xR(j,1)); 
    ind = PI0 == 0;
    ind = ind .* eps;
    PI0 = PI0 + ind;
    clear ind
    w0 =  sum(PI0); 
    H0 = -sum((PI0/w0).*(log2(PI0/w0)));
    fitR(j) = fitR(j) + H0;
    
    for jl = 2: level
        PI0 = PI(xR(j,jl-1)+1:xR(j,jl)); 
        ind = PI0 == 0;
        ind = ind .* eps;
        PI0 = PI0 + ind;
        clear ind
        w0 =  sum(PI0); 
        H0 = -sum((PI0/w0).*(log2(PI0/w0)));
        fitR(j) = fitR(j) + H0;
    end  
end








