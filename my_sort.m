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

