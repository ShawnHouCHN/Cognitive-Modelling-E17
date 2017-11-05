clear all, close all

exp_number='1';
name=strcat('results',exp_number,'.mat');
%data=experiment_fun('random');
data=experiment_fun('forced');
save(name,'-struct','data')