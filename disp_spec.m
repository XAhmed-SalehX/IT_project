function disp_spec(entropy,avgLength,efficiency,compression,total_freq,decoded_message)
    fprintf('Encoding is done on %d total characters\n',total_freq);
    fprintf('The Entropy of symbols is %0.2f bits\n',entropy);
    fprintf('The Average Code Length is %0.2f bits/symbol\n',avgLength);
    fprintf('The Efficiency of encoding is %0.2f%%\n',efficiency*100);
    fprintf('The Compression Ratio is %0.2f%%\n\n',compression*100);
    fprintf('You will find the encoded text in the same directory\n');
    if (length(decoded_message) < 50)
        fprintf('The Decoded Message is:\n');
        fprintf('-- %s --\n\n',decoded_message);
    else
        fprintf('You will find the decoded text in the same directory\n\n');
    end
end