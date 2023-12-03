function [comp_ratio] = calc_comb (total_freq,symbol)
%{
  This function calculates the compression ratio after encoding the text
  input:  - total number of characters in the text
          - array of structs of symbols with fields -- length & freq
  output: - compression ratio done by encoding
%}
    
    % size before = no. of chars * size of one char(8-bits)
    size_before = total_freq * 8;
    
    % size after = code length of a char * frequency
    size_after = 0;
    for i = 1:numel(symbol)
        size_after = size_after + (symbol(i).length * symbol(i).freq);
    end
    
    comp_ratio = size_after/size_before;
end
