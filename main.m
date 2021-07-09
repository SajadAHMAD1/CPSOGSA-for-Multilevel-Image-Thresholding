
                      
%              CPSOGSA for Multilevel Image Thresholding
% 

%Publication: Rather, S. A., & Bala, P. S. (2021). Constriction Coefficient Based Particle Swarm Optimization and Gravitational Search Algorithm for Multilevel Image Thresholding. Expert Systems, doi: 10.1111/exsy.12717, Wiley, SCIE (I.F = 2.587)%% 


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
    
clear all
close all
clc

% Parameter initialization
     I = imread('Aeroplane.tiff');
%    I = imread('Cameraman.tiff');
 
  level = 5; %% Threshold = level-1 
% 
 N_PAR = level;                          %number of thresholds (number of levels-1) (dimensiones)
 dim = N_PAR;  
% 
 n = 15;                                  % Size of the swarm " no of objects " %%% Default (n = 15)
 Max_Iteration  = 300;                    % Maximum number of "iterations"      %%% Default (Max_Iteration  = 300)
% 
if size(I,3) == 1 %grayscale image
[n_countR, x_valueR] = imhist(I(:,:,1));
end
Nt = size(I,1) * size(I,2); 
 
% % Lmax indicated color segments 0 - 256

Lmax = 256;   %256 different maximum levels are considered in an image (i.e., 0 to 255)

for i = 1:Lmax
    if size(I,3) == 1  
        %grayscale image
        probR(i) = n_countR(i) / Nt;
    end
end
if size(I,3) == 1
    up = ones(n,dim) * Lmax;
    low = ones(n,dim);
end
 tic
 RunNo  = 1;   
    for k = [ 1 : RunNo ]  
       [CPSOGSA_bestit,CPSOGSA_bestF,CPSOGSA_Fit_bests]= CPSOGSA(I, Lmax, n,Max_Iteration,low,up,dim, level, probR);
       BestSolutions1(k) = CPSOGSA_bestF; 
 disp(['Run # ' , num2str(k),'::' 'Best estimates =',num2str(CPSOGSA_bestit)]);         % CPSOGSA
    end  
% /* Boxplot Analysis */
   figure
   boxplot([BestSolutions1'],{'CPSOGSA'});
   color = [([1 0 0])];
   h = findobj(gca,'Tag','Box'); 
   for j=1:length(h) 
   patch(get(h(j),'XData'),get(h(j),'YData'),color(j));
   end 
   title ('\fontsize{15}\bf Aeroplane (k=2)');
   % %  title ('\fontsize{15}\bf  Cameraman (k=2)');
   xlabel('\fontsize{15}\bf Algorithms');
   ylabel('\fontsize{15}\bf Best Fitness Values');
   box on
% % % 

% /* Graphical Analysis*/
figure
 plot(CPSOGSA_Fit_bests,'DisplayName','CPSOGSA','Color','b','LineStyle','-','LineWidth',3);
 disp( ['Time_CPSOGSA =', num2str(toc)]); 
 title ('\fontsize{15}\bf Aeroplane (k=2)'); % k=2,4,6,8,10
 % %  title ('\fontsize{15}\bf Cameraman (k=2)');
 xlabel('\fontsize{15}\bf Iterations');
 ylabel('\fontsize{15}\bf Fitness values');
 legend('\fontsize{12}\bf CPSOGSA');
 %
 %
 gBestR = sort(CPSOGSA_bestit);
 Iout = imageGRAY(I,gBestR);
 Iout2 = mat2gray(Iout); 
 
% % Show results on images  

figure
imshow(Iout)
    
figure
imshow(I)
    
% % Show results

intensity = gBestR(1:dim-1);  
STDR  = std(CPSOGSA_Fit_bests)              %Standard deviation of fitness values       
MSEV = MSE(I, Iout)                         %Mean Square Error
PSNRV = PSNR(I, Iout)                       %PSNR between original image I and the segmented image Iout
SSIMV = ssim (I, Iout)                      %SSIM Quality Measure
FSIMV = FeatureSIM (I, Iout)                %FSIM Quality Measure
Best_Fitness_Value= CPSOGSA_Fit_bests(k)    %Best fitness
     
% % Plot the threshold values over the histogram
figure 
plot(probR)
    hold on
vmax = max(probR);
for i = 1:dim-1
    line([intensity(i), intensity(i)],[0 vmax],[1 1],'Color','r','Marker','.','LineStyle','-')
    title ('\fontsize{15}\bf Aeroplane (k=2)');
% title ('\fontsize{15}\bf  Cameraman (k=2)');
    xlabel('\fontsize{15}\bf Gray level');
    ylabel('\fontsize{15}\bf Frequency');
    hold off
end    
