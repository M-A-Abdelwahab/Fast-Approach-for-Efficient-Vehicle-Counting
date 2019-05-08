%% "Fast approach for efficient vehicle counting" 
%  This is a MATLAB code for the method described in the above paper.
%  The code is released for research purposes only. 
% If you use this software or part of it, please cite the this article:
% @ARTICLE{
%    author = {M.A. Abdelwahab},
%    ISSN = {0013-5194},
%    title = {Fast approach for efficient vehicle counting},
%    journal = {Electronics Letters},
%    issue = {1},   
%    volume = {55},
%    year = {2019},
%    month = {January},
%    pages = {20-22(2)},
%    url = {https://digital-library.theiet.org/content/journals/10.1049/el.2018.6719}
% }
%%
% Copyright (c) 2019, M.A. Abdelwahab
% abdelwahab@aswu.edu.eg
%% *********************************************************************************************************************
% You should change "videoname" to your video name, also you should change "VehSize" and "VehSize"parameters according to the average vehicle size used in the video  
% Select the appropriate ROI (line) that the car will be counted when passing through it.
%%
clear
% clc


videoname='M-30.avi'; 
videoFileReader=vision.VideoFileReader(videoname,'PlayCount',1,'VideoOutputDataType','Inherit');%Inherit

detector1 = vision.ForegroundDetector(....
    'MinimumBackgroundRatio',.5,....
         'InitialVariance', 50*50,....
     'NumTrainingFrames', 50); 
   
detector2 = vision.ForegroundDetector(....
     'MinimumBackgroundRatio',.5,....
            'InitialVariance', 50*50,....
       'NumTrainingFrames', 50); 
      
   
I      = step(videoFileReader);
[M,N,~]=size(I);
se1 = strel('rectangle',[30 30]);
% se2 = strel('rectangle',[15 15]);
VehSize=250;                  % the average vehicle size in pixels
OveLap=20;                    % a threshould for common area between two objects in two consequent frames.
L0=zeros(31,496);           % intialize the forground detction in ROI  
currCars=0;CarNum=0;

% vidObj = VideoWriter('M30_2Models_25_25_Size250_000.avi');
%  vidObj.FrameRate=15;
%  open(vidObj);


for g=0:50:2300

    reset(detector1)

    for i=1:25
        f=g+i
        
        
I      = step(videoFileReader);  
ROI=I(250:280,150:645,:);
fgMask1 = step(detector1, ROI);
fgMask2 = step(detector2, ROI);



closeBW1 = imclose(fgMask1,se1);  
closeBW2 = imclose(fgMask2,se1);  

black1=zeros(M,N);black1(250:280,150:645)=closeBW1; %(350:380,:);
black2=zeros(M,N);black2(250:280,150:645)=closeBW2; %(350:380,:);

[L,NUM] = bwlabel(closeBW2);
L1=LabelEnhanc(L,VehSize);
[currCars,CarNum]=CheckSameCar(L0,L1,currCars,CarNum,OveLap);
L0=L1;
  
  subplot(2,1,1)
  I(250:280,150:645,1)=255;    % ROI highlighting
  imshow(I);
  title(['Frame      '  mat2str(f)             '------   Vehicle number= ' mat2str(CarNum)])
  subplot(2,1,2) 
  imshow(black2);
  title(['Foreground2   Frame      '  mat2str(f)             '------   Vehicle number= ' mat2str(CarNum)])
   pause(.001)

% FrameO = insertText(I, [1 1],  ['Frame ' num2str(f) '     CarNo ' num2str(CarNum)], 'AnchorPoint', 'LeftTop','FontSize', 20,'BoxOpacity',1);
%  writeVideo(vidObj,FrameO);  
    end
   
    
  reset(detector2)    
 for i=1:25
     f=g+i+25

I      = step(videoFileReader);  
ROI=I(250:280,150:645,:);
fgMask1 = step(detector1, ROI);
fgMask2 = step(detector2, ROI);



closeBW1 = imclose(fgMask1,se1);  
closeBW2 = imclose(fgMask2,se1);  
black1=zeros(M,N);black1(250:280,150:645)=closeBW1; %(350:380,:);
black2=zeros(M,N);black2(250:280,150:645)=closeBW2; %(350:380,:);

[L,NUM] = bwlabel(closeBW1);
L1=LabelEnhanc(L,VehSize);
[currCars,CarNum]=CheckSameCar(L0,L1,currCars,CarNum,OveLap);
L0=L1;
  
  subplot(2,1,1)
  I(250:280,150:645,1)=255;     % ROI highlighting
  imshow(I);
  title(['Frame      '  mat2str(f)             '------   Vehicle number= ' mat2str(CarNum)])
  subplot(2,1,2) 
  imshow(black1);
  title(['Foreground1     Frame '  mat2str(f)             '------   Vehicle number= ' mat2str(CarNum)])
  pause(0.001)

% FrameO = insertText(I, [1 1],  ['Frame ' num2str(f) '     CarNo ' num2str(CarNum)], 'AnchorPoint', 'LeftTop','FontSize', 20,'BoxOpacity',1);
%  writeVideo(vidObj,FrameO);
 
 
 

 
 end
    
    
    
    
    
    
    
    
    
    
    
    
    
end
%%
% close(vidObj);




































