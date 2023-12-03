function [efficiency,avgLength,symbol] = calc_eff(symbol,entropy)
%{
  this function calculates the efficiency of the encoding
  input: symbol with three fields -- name, code and probability of each
  output: - the efficiency of the encoding
          - the code average length
%}
%% Firstly: we initialize the total length and the average length
    total_length = 0;   % needed to calculate code average length
    avgLength = 0;
    
%% Secondly: we calculate the length of each code and increment the total length
for i = 1:numel(symbol)
   symbol(i).length = strlength(symbol(i).code);
   total_length = total_length + symbol(i).length;
end

%% Thirdly: we calculate the code average length
for i = 1:numel(symbol)
    avgLength = avgLength + symbol(i).probab * symbol(i).length;
end

%% Fourthly: we calculate the efficiency
 efficiency = entropy/avgLength;
    
end
