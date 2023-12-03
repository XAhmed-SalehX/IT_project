function encodedText = encoding(symbol, text, encodefilepath)
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
