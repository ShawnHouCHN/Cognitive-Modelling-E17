clear all, close all

load ('images')
load('emotion strength')
%load('ordered_total_results')

for k=1:8
    for i=1:15
    image_to_show=reshape(images(k,:),195,231)';
   image_to_show=imresize(image_to_show, 4);
   scrsz = get(0,'ScreenSize');
   figure('Position',[scrsz(3)/4 scrsz(4)/3 scrsz(3)/2 scrsz(4)/2])
   imshow(image_to_show), colormap gray
   title(emotion_strength(k),'FontSize',16)
   axis equal
   pause(1.5)
   %emotion_strength(k)
   %ordered_responses(k,:)
   close all
   k=k+8;
   end

end


