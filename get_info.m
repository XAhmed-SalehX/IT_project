function [symbol,entropy,total_freq] = get_info(symbol)
%{
  This function is used to calculate the probability of each symbol and add
  an additional field to the struct to hold this probability, also a field
  for the information of each symbol. Also it calculates the entropy of the
  whole text.
  input: array of structs "symbol"
  output: - symbol with additional two fields - probability & information
          - the entropy of the whole text.
          - total frequency needed for compression calculations
%}
%% Firstly: we initialize the freq and the entropy needed in looping
    total_freq = 0;     % needed to calculate the probability
    entropy = 0;

%% Secondly: we calculate the total frequency by summing each symbol freq.    
    for i = 1:numel(symbol)
        total_freq = total_freq + symbol(i).freq;
    end

%% Thirdly: we calculate the probability, information & length of each symbol & entropy
    for i = 1:numel(symbol)
        symbol(i).probab = symbol(i).freq/total_freq;
        symbol(i).info = -log2(symbol(i).probab); 
        entropy = entropy + symbol(i).probab*symbol(i).info;
    end
end
