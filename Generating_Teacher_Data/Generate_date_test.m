clear;
L=[0.2 0.3 0.3 0.3 0.3 0.5];L=[0.2 0.3 0.3 0.3 0.3 0.5]; %linear memory task
Q=[0.2 0.1 0.1 0.1; 0.1 0.3 0.2 0.1; 0.1 0.2 0.4 0.1; 0.1 0.1 0.1 0.8]; %quadratic memory task
T=10000;
Generate_data_linear_memory_task(L,T);
Generate_data_quadratic_memory_task(Q,T);