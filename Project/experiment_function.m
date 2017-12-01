function data_collected=experiment_function

format long
load ('images.mat')
[n_images,~]=size(images);


perm_indexes=randperm(n_images);
    

Ntrials=n_images;

%display instructions
scrsz = get(0,'ScreenSize');
figure('Position',[scrsz(3)/4 scrsz(4)/4 scrsz(3)/2 scrsz(4)/2])
set(gca,'xlim',[-100 100])
set(gca,'ylim',[-100 100])
axis off

h(1)=text(0,60,'Welcome to the experiment!','FontSize',20,'HorizontalAlignment','Center');
h(2)=text(0,40,'We will show you some images of human faces','FontSize',20,'HorizontalAlignment','Center');
h(3)=text(0,20,'Press the right arrow if you think the person in the picture is happy','FontSize',20,'HorizontalAlignment','Center');
h(4)=text(0,0,'Press the left arrow if you think the person in the picture is sad','FontSize',20,'HorizontalAlignment','Center');
h(5)=text(0,-20,'Your reaction time is measured, so be fast, but also be precise!','FontSize',20,'HorizontalAlignment','Center');
h(6)=text(0,-40,'Press any key to start the experiment','FontSize',20,'HorizontalAlignment','Center');

pause
delete(h), clear h
FlushEvents
close all


RT=zeros(Ntrials,1);
response=zeros(Ntrials,1);
indexes_images=zeros(Ntrials,1);

trial=1;
good_trial=1;



while (good_trial<Ntrials || good_trial==Ntrials)
   
 
   indexes_images(good_trial)=perm_indexes(trial);
   trial=trial+1;
   image_to_show=reshape(images(indexes_images(good_trial),:),195,231)';
   image_to_show=imresize(image_to_show, 4);
   figure('Position',[scrsz(3)/4 scrsz(4)/3 scrsz(3)/2 scrsz(4)/2])
   imshow(image_to_show), colormap gray
   axis equal
   
   [resp, time] = GetResponse();
    RT(good_trial)=time;
    response(good_trial)=resp;
    %response
    %WaitSecs(0.55);
    if ( RT(good_trial)>0.2 || RT(good_trial)==0.2)
        good_trial=good_trial+1;
    else
        perm_indexes=[perm_indexes,indexes_images(good_trial)];
    end
   
    close all
    pause(0.55)
end
    
%keyboard
perm_indexes
data_collected=struct('ind',indexes_images,'resp',response,'time',RT);

%data_collected=[indexes_images,response,RT];
%dataFile = fopen(dataFileName, 'a');'
%fprintf(dataFile,data_collected);
%fclose(dataFile);


return

