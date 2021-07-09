
                      
%              CPSOGSA for Multilevel Image Thresholding
% 


%   Programmer: Sajad Ahmad Rather      
%   Developed in MATLAB R2016a 

%               Department of Computer Science and Engineering
%               School of Engineering and Technology
%               Pondicherry University- 605014, India
%                  
%                 E-Mail: sajad.win8@gmail.com                   
%                                                                         
%            %              Homepage: https://github.com/SajadAHMAD1  
%                        https://in.mathworks.com/matlabcentral/profile/authors/6240015-sajad-ahmad-rather                          
%   

function MSE = MSE(origImg, distImg)

origImg = double(origImg);
distImg = double(distImg);

[M N] = size(origImg);
error = origImg - distImg;
MSE = sum(sum(error .* error)) / (M * N);
