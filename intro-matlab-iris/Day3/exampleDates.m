
%% Setup

clear, clc

%% Create dates

% This is how to create a quarterly date object representing the 3rd
% quarter of 2021
d = qq(2021, 3)

% Other available frequencies are: daily, weekly, monthly, semi-annual,
% annual. The corresponding date creator functions are:
% dd(2021, 11, 16);
% ww(2021, 46);
% mm(2021, 11);
% hh(2021, 2);
% yy(2021);

% Dates can also be created from strings
% d = str2dat("2021-11-15", "DateFormat", "yyyy-mm-dd", "Freq", 4)

%% Date properties

% Frequency
get(d, "Frequency")

% Year
get(d, "Year")

% Year/period/frequency
[y, p, f] = dat2ypf(d)

%% Calculations

% We can add intergers to dates
d1 = d + 12

% And we can calculate the number of periods between two dates
p = d1 - d

% We always have
% d1 = d + (d1 - d)

% It is essential here to use the parenthesis; without the prenthesis we'll
% get an error. Can you explain why?

%% Comparisons

% The usual comparison operators also work for dates
d <= d1
d1 == d
% etc.

%% Create ranges

% Date ranges can be created using the : (colon) operator
rng = d : d1

% The step between consecutive elements can also be given
rng = d : 4 : d1

%% Concatenation

% Similar to any other MATLAB variables, date can be concatenated both
% horizotnally and vertically
[d, d1]

% The concatenated dates do not have to be in increasing order
[d1; d] 

%% Convert dates

% Covnerting dates to another freqeuncy is easy
d2 = convert(d, "y") % This will convert to an annual date

% When converting to higher frequency, the result will correspond to the
% first high frequency period in the low freqency date
d3 = convert(d, 12) % This will convert to monthly

% It is advisable to use the special Frequency object to clearly indicate
% the frequency
d4 = convert(d, Frequency.Daily) % This will convert to daily frequency

%% Conversion to strings

% dat2char converts the date into the IRIS default string representation
dat2char(d)

% For daily and weekly dates, we may also want to convert to calendar
% representations
d = dd(2021, 11, 15);
dat2char(d, "dateFormat", "$DDMmm, YYYY")

% Type help dat2char for more options