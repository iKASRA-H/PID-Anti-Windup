% KASRA HASSANI   9923107

% Purpose of this code:
% Creating a closed-loop transfer function using G(s) and PID
% Printing individual coefficients of PID after tuning with G(s)
% Kp, Kd, Ki
% Plotting the step response of the combination of G(S) and PID
% Plotting the first plot with different omegas

% Clearing and Closing Everything
clc; clear; close all;
%-------------------------------------------

% Making Transfer Function for G(s)
s = tf('s');
G = 1 / (s * (s + 1));
%-------------------------------------------

% Tuning G(s) for PID
% Other Options = P, PI, PD
C = pidtune(G, 'PID');
%-------------------------------------------

% Accessing the Individual Coefficients
Kp = get(C, 'Kp');
Kd = get(C, 'Kd');
Ki = get(C, 'Ki');
x = sprintf('Kp = %f',Kp);
disp(x);
y = sprintf('Kd = %f',Kd);
disp(y); 
z = sprintf('Ki = %f',Ki);
disp(z);
%-------------------------------------------

% Closed-Loop Transfer Function
T = feedback(C * G, 1);
%-------------------------------------------


% Step Response Plot
figure(1);
step(T);
%-------------------------------------------

%------------positioning figure 1-----------
pos1 = get(gcf,'Position'); % get position of Figure(1) 
set(gcf,'Position', pos1 - [pos1(3)/2,0,0,0]) % Shift position of Figure(1) 
%-------------------------------------------


% Showing different Omegas
omega_min = 1; % minimum omega value
omega_max = 10; % maximum omega value
omega_step = 1; % omega increment
omega = omega_min:omega_step:omega_max; % omega vector
figure(2); % create a new figure
hold on; % hold the plot
for i = 1:length(omega)
    T_omega = T * exp(-omega(i) * s); % apply the time delay
    step(T_omega); % plot the step response
end
hold off; % release the plot
legend(num2str(omega')); % add a legend with omega values
xlabel('Time (s)'); % add x-axis label
ylabel('Output'); % add y-axis label
title('Step response of closed loop transfer function with different omegas'); % add title
%-------------------------------------------


%---positioning figures 1, 2 side by side---
set(gcf,'Position', get(gcf,'Position') + [0,0,150,0]); % When Figure(2) is not the same size as Figure(1)
pos2 = get(gcf,'Position');  % get position of Figure(2) 
set(gcf,'Position', pos2 + [pos1(3)/2,0,0,0]) % Shift position of Figure(2)
%-------------------------------------------

