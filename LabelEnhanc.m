function L1=LabelEnhanc(L,VehSize)
%% To remove small objects and re-labeling
% L is object labels
% VehSize is the min acceptable size of an object
L1=zeros(size(L));
STATS = regionprops(L);

c=1;
for i=1:size(STATS,1)
  Ar=  STATS(i).Area;
  if Ar>VehSize  
  L1(L==i)=c;
  c=c+1;
  end
    
    
    
    
end