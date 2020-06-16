function [currCars,CarNum1]=CheckSameCar(L0,L1,currCars0,CarNum,OveLap)
% The purpose of this function is to check if the current foreground object is representing a new car or existing one  
% Copyright (c) 2019, M.A. Abdelwahab
% abdelwahab@aswu.edu.eg
% If you use this software or part of it, please cite the this article: 
% Abdelwahab, M. A. "Fast approach for efficient vehicle counting." Electronics Letters 55.1 (2019): 20-22.

%% ______________________________________________________________________
% L0 and L1 are binarry images Fg=1,Bg=0 each of them contain fg objects wiith differnt labels.
 % OveLap: the min overlap between the current and prevois detected objects
 
 
CarNum1=CarNum;
A=unique(L0(L0>0));
B=unique(L1(L1>0));
if ~isempty(B)
currCars=zeros(1,length(B));
else
 currCars=0;   
end

if ~isempty(A)
    
for i=1:length(B)
  mas1=L1==B(i);  
  ss=zeros(1,length(A));
  
  for j=1:length(A)
  mas0=L0==A(j);
  ss(j)=sum(sum(mas0&mas1));
  end
  [Smax,Idx]=max(ss);
  if Smax>OveLap  
    currCars(i)= currCars0(Idx); 
  else
  CarNum1=CarNum1+1;
  currCars(i)= CarNum1; 
  end

end


else
    
if ~isempty(B)    
CarNum1=CarNum1+1;    
currCars=  CarNum1: CarNum1+length(B)-1;
end    
    
    
end
