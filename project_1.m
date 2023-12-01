clear;clc;
filepath = 'trial.txt';
[text, symbol] = get_symbols(filepath);

function [text, symbol] = get_symbols(file_path)
%% Firstly:  we initialize a struct to have two fields.
% one for name of every unique char, and the other for the number of occurrence
	symbol = struct('name',{}, 'freq',{});
    
%% Secondly: we open the text file and import the data into an array
% the format spec will be of type char; to have an array of characters
% that fulfill our requirement to scan each character

    fileID = fopen(file_path,'r');          % open the file to read
    formatSpec = '%c';                      % define the type of scanning
    text = fscanf(fileID, formatSpec);      % scan the file
    fclose(fileID);                         % close the file
    
%% Thirdly: we loop along each element in the array to calculate the frequency

    % for each element in the array
    for i = 1:numel(text)   
        % compare between the current char and the chars in the struct
        char_ID = find(strcmp({symbol.name},text(i))); 
        % if it's the first time to be seen
        if isempty(char_ID)
            % add a new element to the struct and assign it to the new char
            symbol(end+1).name = text(i);
            % set the freq to 1, as it's the first time to be seen
            symbol(end).freq = 1;
        % if it already exists, char_ID will have its index in the struct
        else
            % increment the frequency of this char
            symbol(char_ID).freq = symbol(char_ID).freq + 1;
        end
    end
    
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
