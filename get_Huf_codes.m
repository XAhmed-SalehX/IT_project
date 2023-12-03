function [huffman_dict] = get_Huf_codes (symbols)
    %{
        Generates Huffman codes for a set of symbols.

        Input:
            - symbols: Array of structs with 'name' and 'probab' fields.
        Output:
            - huffman_dict: Array of structs with 'name' and 'code' fields.
    %}

    temp = struct('name',[],'probab',[],'freq',[]);
    for i = 1:numel(symbols)
        temp(i).name = symbols(i).name;
        temp(i).info = symbols(i).info;
    	temp(i).freq = symbols(i).freq;
        temp(i).probab = symbols(i).probab;
    end
    
    % Use array comprehension to remove freq and info
    symbols = arrayfun(@(x) rmfield(x, 'freq'), symbols);
    symbols = arrayfun(@(x) rmfield(x, 'info'), symbols);

    % add New field child and code
    symbols = arrayfun(@(x) setfield(x, 'child', []), symbols);
    symbols = arrayfun(@(x) setfield(x, 'code', []), symbols);
    
    % sort the symbols based on thier probabilities 
    symbols = my_sort(symbols);

    % Begin the tree
    tree(1).level = symbols;

    % Loop counter
    i = 1; 
    while numel(tree(end).level) > 1
        %{
            Huffman Tree Construction Loop:
            - Continues until only one symbol remains in the forest.
            - Combines the two symbols with the least probabilities.
            - Builds a new symbol with a combined name, probability, and child nodes.
            - Updates the tree structure and sorts the remaining symbols.
            - Increments the loop counter.
        %}
        % least probabilities
        s1 = tree(i).level(end);
        s2 = tree(i).level(end-1);
        % combine
        s1s2.name = [s1.name s2.name];
        s1s2.probab = s1.probab + s2.probab;
        s1s2.child = {s1 s2};
        s1s2.code = [];
        % replace
        tree(i+1).level = tree(i).level(1:end-1);
        tree(i+1).level(end) = s1s2;
        %sort
        tree(i+1).level = my_sort(tree(i+1).level);
        % i++
        i = i +1;
    end

    % Extract the Huffman tree from the final level of the tree structure
    huff_tree = tree(end).level;

    % Initialize an empty dictionary
    global huffman_dict 
    huffman_dict = struct('name', {}, 'code', {});

    % Traverse the Huffman tree and construct the dictionary
    traverse_tree(huff_tree, '');
    % Function to traverse the Huffman tree and construct the dictionary
    function traverse_tree(symbol, current_code)
        %{
            Recursively traverses the Huffman tree to construct the
            Huffman code dictionary.

            Input:
                - symbol: Current symbol in the Huffman tree.
                - current_code: The Huffman code built so far.
            Output:
                - None (updates the global variable 'huffman_dict').
        %}
        if isempty(symbol.child)  % stop condition (last child)
            % Add the symbol and its code to the dictionary
            huffman_dict(end+1).name = symbol.name;
            huffman_dict(end).code = current_code;
        else  % function in action 
            % Traverse the left child with appended '1' to the current code
            traverse_tree(symbol.child{1}, strcat(current_code, '1'));
            % Traverse the right child with appended '0' to the current code
            traverse_tree(symbol.child{2}, strcat(current_code, '0'));
        end
    end
    function sortedS = my_sort(s)
    %{
        Sorts an array of structs based on the 'probab' field in descending order.
        Input:
            - s: Array of structs with a 'probab' field.
        Output:
            - sortedS: Array of structs sorted based on 'probab'.
    %}
        % Extract symbol probabilities
        probab = [s.probab];
        % Sort the intreees based on 'probab' values
        [~, sorted_Intreees] = sort(probab, 'descend');
        % Arrange the structs based on sorted intreees
        sortedS = s(sorted_Intreees);
    end


    for i = 1:numel(huffman_dict)  % Assuming huffman_dict is the array of structs to be updated
        idx = find(strcmp({temp.name}, huffman_dict(i).name));  % Find the corresponding name in 'temp'
            if ~isempty(idx)
                huffman_dict(i).freq = temp(idx).freq;          % Copy 'freq' from 'temp' to 'huffman_dict'
                huffman_dict(i).info = temp(idx).info;          % Copy 'info' from 'temp' to 'huffman_dict'
                huffman_dict(i).probab = temp(idx).probab;      % Copy 'probab' from 'temp' to 'huffman_dict'
            else
                disp('Letter is lost');
            end
    end
end
