function [modStruct] = wadeModelImport(filename)
rowStart = 1;
colStart = 0;


[modOut] = csvread(filename,rowStart,colStart);
modFields = {'height','pressure','theta','temp','dewpt','theta_e','mix_rat','rhum','wind_spd','wind_dir','up_velocity'};

modStruct = struct(modFields{1},modOut(:,1),modFields{2},modOut(:,2),modFields{3},modOut(:,3),modFields{4},modOut(:,4),modFields{5},modOut(:,5),modFields{6},modOut(:,6),modFields{7},modOut(:,7),modFields{8},modOut(:,8),modFields{9},modOut(:,9),modFields{10},modOut(:,10),modFields{11},modOut(:,11));
end