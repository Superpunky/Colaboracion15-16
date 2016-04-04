function [PIN TA] = axisfromname1(images_info)

   posPIN = 4:5;
   posTA = 8:12;

for n = 1:length(images_info)
   PIN(n) = str2num(images_info(n).name(posPIN));
   TA(n) = str2num(images_info(n).name(posTA));
end