display('juba')


function [message, symbols] = get_string (file_path)
    % inputs : .txt file path exget_string ( trial.txt )
    % to do : number of unique symbols, frequncy of each element
    % outputs : vector of structs -> each element is struct with 2 fields 
    % name and frequency ex: S1.name = 'a'; S1.freq = 100
    % outputs : string contains the message for transmition
end

function [symbols] = get_info (symbols)
    % inputs : vector of structs -> each element is struct with 2 fields 
    % to do : probabilty, information and entropy.
    % output : vector of structs -> each element is struct with 5 fields 
    % name, frequency, P, I, H ex: S1.name = 'a'; S1.freq = 100 ;S1.I = 2
    %S1.H = 2
end

function [huf_codes] = get_Huf_codes (symbols)
    % inputs : vector of structs -> each element is struct with 5 fields 
    % to do : Dictionary and Huffman code
    % output : vector of structs -> each element is struct with 2 fields 
    % symbol and code
end

function [coded_messege] = TX (huf_codes, message)
    % inputs : vector of structs -> each element is struct with 2 fields 
    % to do : replace each symbol with code
    % output : string contains the coded message
end

function [decoded_messege] = RX (huf_codes, coded_messege)
    % inputs : string contains the coded message
    % to do : replace each code with symbol
    % output : string contains the decoded message
end

function [decoded_messege] = Compare_messege (coded_messege, decoded_messege)
    % inputs : coded_messege and decoded_messege
    % to do : Compare
    % output : any losses
end

% ======================================================================= %

function [] = calc_eff ()
    % to do : Calculate the efficiency achieved by the code.
end

function [] = calc_comb ()
    % to do : Calculate the compression ratio of the coded file.
end
