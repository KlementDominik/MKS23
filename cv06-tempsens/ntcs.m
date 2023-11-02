
clc
clear all
%% Import data from text file
% Script for importing data from the following text file:
%
%    filename: C:\Temp\xkleme13\MKS23\cv06-tempsens\ntc.csv
%
% Auto-generated by MATLAB on 02-Nov-2023 14:57:34

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 2);

% Specify range and delimiter
opts.DataLines = [1, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Temp", "Resitance"];
opts.VariableTypes = ["double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
ntc = readtable("C:\Temp\xkleme13\MKS23\cv06-tempsens\ntc.csv", opts);


%% Clear temporary variables
clear opts

% Fit a high-degree polynomial to the data (degree 10)
p = polyfit(ntc.Resitance, ntc.Temp, 10);

% Create a range of ADC values (ad2) from 0 to 1023
ad2 = 0:1023;

% Calculate corresponding temperature values using the fitted polynomial
t2 = round(polyval(p, ad2), 1);

% Plot the original data points
plot(ntc.Resitance, ntc.Temp, 'o', 'MarkerFaceColor', 'b');
hold on;

% Plot the temperature values for the new ADC range
plot(ad2, t2, 'r', 'LineWidth', 1.5);

% Customize the plot
xlabel('ADC Values');
ylabel('Temperature (°C)');
title('ADC Values vs. Temperature');
legend('Data Points', 'Fitted Curve');
grid on;
hold off;

% Save the temperature values in the specified format
dlmwrite('data.dlm', t2*10, ',');
