function up-or-prefix-search --description="Depending on cursor position and current mode, either search backward or move up one line"
    if commandline --search-mode
        commandline -f history-prefix-search-backward
        return
    end

    if commandline --paging-mode
        commandline -f up-line
        return
    end

    set lineno (commandline -L)

    switch $lineno
        case 1
            commandline -f history-prefix-search-backward

        case '*'
            commandline -f up-line
    end

end
