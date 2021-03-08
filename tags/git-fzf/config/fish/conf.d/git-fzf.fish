function git-fzf-commits-widget
    set -l results (git-fzf-commits)
    and commandline -i "$results"
    commandline -f repaint
end
function git-fzf-files-widget
    set -l results (git-fzf-files)
    and commandline -i "$results"
    commandline -f repaint
end

bind \cg\ch git-fzf-commits-widget
bind \cg\cf git-fzf-files-widget
