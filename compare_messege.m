function failed = compare_messege(decoded_message, text)
failed = 0;
    for i=1:numel(text)
        match = strcmpi(decoded_message(i),text(i));
        if (match == false)
            failed = 1;
        end
    end
end
