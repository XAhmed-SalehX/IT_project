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
