%% Clearing command window & workspace
clear;clc;

%% Define file paths
textfilepath    = 'trial.txt';       % text file to be encoded
encodefilepath  = 'encoded.txt';     % encoded text file
decodefilepath  = 'decoded.txt';     % decoded text file

%% Preamble to encoding
[text, symbol] = get_symbols(textfilepath);             % generate symbols of the text file
[symbol,entropy,total_freq] = get_info(symbol);         % calculate entropy, probability & information of each symbol
[huffman_code,huffman_dict] = get_Huf_codes(symbol);    % generate huffman dictionary

%% Encoding
encoded_message = encoding(huffman_code, text, encodefilepath);             % encoding the text file using huffman codes
decoded_message = decoding(huffman_code, encoded_message, decodefilepath);  % decode the previously encoded text
failed = compare_messege(decoded_message, text);                            % compare the result of decoding and the original text

%% Generate Huffman Encoding specs
if (failed == 0)    % in case the decoding succeed
    [efficiency,avgLength,symbol] = calc_eff(huffman_code,entropy);                 % calculate the efficiency,  code average length
    [comp_ratio] = calc_comb (total_freq,symbol);                                   % calculate the compression ratio
    disp_spec(entropy,avgLength,efficiency,comp_ratio,total_freq,decoded_message)   % display the results in command window

else % in case failure of decoding
    disp('There''s error in decoding, Revise your design');                 
end
