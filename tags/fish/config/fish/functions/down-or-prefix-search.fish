function down-or-prefix-search --description="Depending on cursor position and current mode, either search forward or move down one line"
    if commandline --search-mode
        commandline -f history-prefix-search-forward
        return
    end

    if commandline --paging-mode
        commandline -f down-line
        return
    end

    set lineno (commandline -L)

    switch $lineno
        case 1
            commandline -f history-prefix-search-forward

        case '*'
            commandline -f down-line
    end

end
