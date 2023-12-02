clear;clc;
textfilepath = 'slides-example-for-test.txt';
encodefilepath = 'encoded.txt';
decodefilepath = 'decoded.txt';

[text, symbol] = get_symbols(textfilepath);
[symbol,entropy,total_freq] = get_info(symbol);

names = {'a','g','m','t','e','h',' ','i','s'};
freqs = {1,1,1,1,2,2,3,3,5};
codes = {'0000','0001','0010','0011','010','011','100','101','11'};
probabs = {0.0526,0.0526,0.0526,0.0526,0.1053,0.1053,0.1579,0.1579,0.2632};
symbol = struct('name', names, 'code', codes,'probab',probabs,'freq',freqs);
[efficiency,avgLength,symbol] = calc_eff(symbol,entropy);
[comp_ratio] = calc_comb (total_freq,symbol)

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
