function decoded_message = decoding(huffman_dict, encoded_message, decodefilepath)
    %{
        Decodes an encoded message using a Huffman dictionary.

        Input:
            - huffman_dict: Array of structs with 'name' and 'code' fields.
            - encoded_message: The encoded message to be decoded.
        Output:
            - decoded_message: The decoded message.
    %}

    % Initialize an empty string to store the decoded message
    decoded_message = '';
    
    % add new field for length
    for i = 1:length(huffman_dict)
        huffman_dict(i).length = length(huffman_dict(i).code);
    end
    codes = {huffman_dict.code};
    start_size = min([huffman_dict.length]);
    max_size = max([huffman_dict.length]);
    counter = 0;
    % Iterate through the encoded message
    while ~isempty(encoded_message)
        % Iterate through the Huffman dictionary to find a matching code
        % search 
        for sample_size = start_size:max_size
            if start_size <=  length(encoded_message)
                sample = encoded_message(1:sample_size);
                if ismember(sample, codes)
                    decoded_message = [decoded_message, huffman_dict(ismember(codes, sample)).name];
                    encoded_message(1:length(sample)) = [];
                    break
                end 
            end
        end
        counter = counter + 1;
    end
    
    fileID = fopen(decodefilepath,'w');
    if fileID == -1
        error('Could not open the file for writing.');
    end
    formatSpec = '%s'; 
    fprintf(fileID,formatSpec,decoded_message);
    fclose(fileID);
end
