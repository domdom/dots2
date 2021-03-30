# if we haven't sourced the interactive config, do it
if status --is-interactive

    # Abbreviations
    abbr --add --global -- :q 'exit'
    abbr --add --global -- l 'll'
    abbr --add --global -- la 'ls -lha'
    abbr --add --global -- less 'less -R'
    abbr --add --global -- ll 'ls -lh'
    abbr --add --global -- v 'vim'

    # Prompt initialisation
    function fish_prompt
        set_color -o
        echo -n (pwd | sed -e "s|^$HOME|~|")
        set_color normal
        echo -n ' $ '
    end

    function save_cmd_to_bash --on-event fish_preexec
        echo $argv >>"$HOME/.bash_history"
    end

    # Interactive shell intialisation
    bind \cj down-or-prefix-search
    bind \ck up-or-prefix-search

    if test -f ~/.fish_local
        source ~/.fish_local
    end
end
