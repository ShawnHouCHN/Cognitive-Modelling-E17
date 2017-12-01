clear all, close all

num_experiments=8;
n_images=120;
results=struct('responses',[],'times',[],'indexes',[]);

indexes=[];
responses=[];
RT=[];
for j=1:num_experiments
    name=strcat('results',string(j),'.mat');
    load(name)
    indexes=[indexes,ind];
    responses=[responses,resp];
    RT=[RT,time];
    clear ind, clear resp, clear time
end
   
results.responses=responses;
results.times=RT;
results.indexes=indexes;

save('total_results.mat','-struct','results')


oredered_results=struct('ordered_responses',[],'ordered_times',[]);

ordered_responses=zeros(n_images,num_experiments);
ordered_RT=zeros(n_images,num_experiments);
 for j=1:num_experiments
        for i=1:n_images
           ind=find(indexes(:,j)==i);
           ordered_responses(i,j)=responses(ind,j);
           ordered_RT(i,j)=RT(ind,j);
    
        end
 end
 
 
 ordered_responses(ordered_responses==1)=-1;
 ordered_responses(ordered_responses==2)=1;
 
 
ordered_results.orded_responses=ordered_responses;
ordered_results.ordered_times=ordered_RT;

save('ordered_total_results.mat','-struct','ordered_results')

%ordered_RT=(ordered_RT-mean(ordered_RT))./std(ordered_RT);
encoded_times=zeros(n_images,num_experiments);

for j=1:num_experiments
    time_mean=mean(ordered_RT(:,j));
    time_std=std(ordered_RT(:,j));
    minimum=time_mean-0.5*time_std;
    maximum=time_mean+3*time_std;
  
  
    bool=(ordered_RT(:,j)<minimum);
    encoded_times(bool,j)=1;
    bool=(abs(ordered_RT(:,j)-time_mean)>3*time_std);
    encoded_times(bool,j)=NaN;
    
    bool=(encoded_times(:,j)==0);
    encoded_times(bool,j)=(ordered_RT(bool,j)-maximum)./(minimum-maximum);
   
end

save('encoded_times','encoded_times')

emotion_strength=zeros(n_images,1);
for i=1:n_images
    bool=(~isnan(encoded_times(i,:)));
    respons=ordered_responses(i,bool);
    tm=encoded_times(i,bool);
    emotion_strength(i)=sum(respons.*tm)/numel(tm);
end

save('emotion strength','emotion_strength')


bool=(emotion_strength>0);
pos=emotion_strength(bool);
mean(pos)
median(pos)
std(pos)


bool=(emotion_strength<0);
neg=emotion_strength(bool);
mean(neg)
median(neg)
std(neg)
