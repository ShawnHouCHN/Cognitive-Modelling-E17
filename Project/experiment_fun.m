function data_collected=experiment_fun(mode)

format long
load ('images.mat')
[n_images,~]=size(images);


i=3;
indexes_happy=[];
while (i<n_images || i==n_images)
        indexes_happy=[indexes_happy,i];
        i=i+8;
end
i=7;
indexes_sad=[];
    while (i<n_images || i==n_images)
        indexes_sad=[indexes_sad,i];
        i=i+8;
    end
    indexes_others=[];
for i=1:n_images
    if(isempty(find(indexes_happy==i)) && isempty(find(indexes_sad==i)))
        indexes_others=[indexes_others,i];
    end
end

if (strcmp(mode,"forced"))
    perm_indexes_happy=indexes_happy(randperm(length(indexes_happy)));
    perm_indexes_sad=indexes_sad(randperm(length(indexes_sad)));
    perm_indexes_others=indexes_others(randperm(length(indexes_others)));
    
else if (strcmp(mode,"random"))
    indexes=randperm(n_images,50);
    else
        printf('Error')
        return
    end
end

Ntrials=30;

%display instructions
scrsz = get(0,'ScreenSize');
figure('Position',[scrsz(3)/2 scrsz(4)/2 scrsz(3)/2 scrsz(4)/2])
set(gca,'xlim',[-100 100])
set(gca,'ylim',[-100 100])
axis off

h(1)=text(0,60,'Welcome to the experiment!','FontSize',20,'HorizontalAlignment','Center');
h(2)=text(0,40,'We will show you some images of human faces','FontSize',20,'HorizontalAlignment','Center');
h(3)=text(0,20,'Press "1" if you think the person in the picture is happy','FontSize',20,'HorizontalAlignment','Center');
h(4)=text(0,0,'Press "0" if you think the person in the picture is sad','FontSize',20,'HorizontalAlignment','Center');
h(5)=text(0,-20,'Your reaction time is measured, so be fast, but also be precise!','FontSize',20,'HorizontalAlignment','Center');
h(6)=text(0,-40,'Press any key to start the experiment','FontSize',20,'HorizontalAlignment','Center');

pause
delete(h), clear h
FlushEvents

RT=zeros(Ntrials,1);
response=zeros(Ntrials,1);
indexes_images=zeros(Ntrials,1);

trial=1;
good_trial=1;
trial_happy=1;
trial_sad=1;
trial_others=1;

 



while (good_trial<Ntrials || good_trial==Ntrials)
   
   if (strcmp(mode,"random"))
        indexes_images(good_trial)=indexes(trial);
        trial=trial+1;
   else
     c=randi(3);
     
     switch (c)
         case 1
             indexes_images(good_trial)=perm_indexes_happy(trial_happy);
             trial_happy=trial_happy+1;
             
         case 2
            indexes_images(good_trial)=perm_indexes_sad(trial_sad);
             trial_sad=trial_sad+1;
             
         case 3
             indexes_images(good_trial)=perm_indexes_others(trial_others);
             trial_others=trial_others+1;
             
     end
     
       
   end
   image_to_show=reshape(images(indexes_images(good_trial),:),195,231)';
   imagesc(image_to_show), colormap gray
   axis equal
    
    tic
    waitforbuttonpress
    RT(good_trial)=toc; %response time
    %response(good_trial)=get(1,'currentcharacter');
    [ch, ~] = GetChar();
    response(good_trial)=ch;
    %response
    %pause(0.55)
    WaitSecs(0.55);
    if (response(good_trial)==49 || response(good_trial)==48)
        good_trial=good_trial+1;
    end

end
    


data_collected=struct('ind',indexes_images,'resp',response,'time',RT);

%data_collected=[indexes_images,response,RT];
%dataFile = fopen(dataFileName, 'a');'
%fprintf(dataFile,data_collected);
%fclose(dataFile);


return

