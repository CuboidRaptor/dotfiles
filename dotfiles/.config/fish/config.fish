function fisher-configure
    # run if fisher is not found and also manually to bootstrap fisher and plugins
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
    fisher install jorgebucaran/fisher
    fisher install IlanCosman/tide@v6
    # tide configuration is in `fish_variables` because that's what `tide configure --auto` does anyways
    fisher install jorgebucaran/autopair.fish
end

if status is-interactive
    # $PATH and other env vars are inherited from environment/login shell
    # which gets it from ~/.environment so they aren't set here

    # last value is default value
    set -gx fisher_path "$__fish_user_data_dir/fisher"
    set fish_complete_path $fish_complete_path[1] $fisher_path/completions $fish_complete_path[2..]
    set fish_function_path $fish_function_path[1] $fisher_path/functions $fish_function_path[2..]
    if not functions --query fisher
        fisher-configure
    end

    # disable welcome
    set fish_greeting

    bind ctrl-shift-Z redo
end
