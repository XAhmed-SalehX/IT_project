clear;clc;
textfilepath = 'slides-example-for-test.txt';
encodefilepath = 'encoded.txt';
decodefilepath = 'decoded.txt';

[text, symbol] = get_symbols(textfilepath);
[symbol,entropy] = get_info(symbol);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Functions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [text, symbol] = get_symbols(file_path)
%{
  This function is used to generate an array of struct, the struct has two
  the array has two fields, one for a name and the other for the frequencey.
  input: file path of the text file
  output: - the text in form of array of chars, 1 row x no. of chars as columns
          - an array of structs of each symbol
%}
%% Firstly:  we initialize a struct to have two fields.
% one for name of every unique char, and the other for the number of occurrence
	symbol = struct('name',{}, 'freq',{});
    
%% Secondly: we open the text file and import the data into an array
% the format spec will be of type char; to have an array of characters
% that fulfill our requirement to scan each character

    fileID = fopen(file_path,'r');          % open the file to read
    if fileID == -1
        error('Could not open the file for reading.');
    end
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

function [symbol,entropy] = get_info(symbol)
%{
  This function is used to calculate the probability of each symbol and add
  an additional field to the struct to hold this probability, also a field
  for the information of each symbol. Also it calculates the entropy of the
  whole text.
  input: array of structs "symbol"
  output: - symbol with additional two fields - probability & information
          - the entropy of the whole text.
%}
%% Firstly: we initialize the freq and the entropy needed in looping
    total_freq = 0; % needed to calculate the probability
    entropy = 0;
    
%% Secondly: we calculate the total frequency by summing each symbol freq.    
    for i = 1:numel(symbol)
        total_freq = total_freq + symbol(i).freq;
    end

%% Thirdly: we calculate the probability, information of each symbol & entropy
    for i = 1:numel(symbol)
        symbol(i).probab = symbol(i).freq/total_freq;
        symbol(i).info = -log2(symbol(i).probab);
        entropy = entropy + symbol(i).probab*symbol(i).info;
    end
end

function [huf_codes] = get_Huf_codes (symbols)
    % inputs : vector of structs -> each element is struct with 5 fields 
    % to do : Dictionary and Huffman code
    % output : vector of structs -> each element is struct with 2 fields 
    % symbol and code
end

function [encoded_message] = encoding(huff_codes, text, encodefilepath)
%{
  This function encodes the text message using the the huffman codes
  input: - array of structs has two fields one for char, and the other for
           the code
         - the path of the encoded text file
  output: the encoded message
%}
%% firstly: Convert text to a cell array of characters
    textCell = num2cell(text);
    
%% Secondly: Loop through each character in the text
    for i = 1:numel(textCell)
        % Find the index where the character matches in the 'name' field of the 'symbol' struct
        char_ID = find(strcmp({symbol.name},textCell(i)));
        % replace the char with the corresponding code
        if ~isempty(char_ID)
            textCell{i} = symbol(char_ID).code;
        end
    end
    
%% Thirdly: Convert the cell array of characters back to a string
    encodedText = [textCell{:}];
    
%% Fourthly: Write the encoded text into a .txt file 
    fileID = fopen(encodefilepath,'w');
    if fileID == -1
        error('Could not open the file for writing.');
    end
    formatSpec = '%s'; 
    fprintf(fileID,formatSpec,encodedText);
    fclose(fileID);
end

function [decoded_messege] = decoding(huf_codes, coded_messege)
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
