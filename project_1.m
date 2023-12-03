clear;clc;
textfilepath = 'trial.txt';
encodefilepath = 'encoded.txt';
decodefilepath = 'decoded.txt';

[text, symbol] = get_symbols(textfilepath);
[symbol,entropy,total_freq] = get_info(symbol);
[huffman_dict] = get_Huf_codes (symbol);

encoded_message = encoding(huffman_dict, text, encodefilepath);
decoded_message = decoding(huffman_dict, encoded_message, decodefilepath);
failed = compare_messege(decoded_message, text);

if (failed == 0)
    [efficiency,avgLength,symbol] = calc_eff(huffman_dict,entropy);
    [comp_ratio] = calc_comb (total_freq,symbol);
    disp_spec(entropy,avgLength,efficiency,comp_ratio,total_freq,decoded_message)
else
    disp('There''s error in decoding, Revise your design');
end
