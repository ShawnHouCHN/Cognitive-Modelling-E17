clear all, close all

exp_number='2';
name=strcat('results',exp_number,'.mat');
data=experiment_function;
save(name,'-struct','data')