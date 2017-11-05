clear all, close all

num_experiments=2;
results=struct('indexes',[],'responses',[],'RT',[],'exp_num',[]);

for i=1:num_experiments
    name=strcat('results',string(i),'.mat');
    load(name)
    results.indexes=[results.indexes;ind];
    results.responses=[results.responses;resp];
    results.RT=[results.RT;time];
    results.exp_num=[results.exp_num;i*ones(numel(ind),1)];
    clear ind, clear resp, clear time
end
    
save('total_results.mat','-struct','results')