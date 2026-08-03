function fisher-configure
    # run if fisher is not found and also manually to bootstrap fisher and plugins
    # it also updates plugins and reloads shell
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
    fisher update # set plugin installation states to `fish_plugins` content
    tide configure --auto --style=Rainbow --prompt_colors='16 colors' --show_time=No \
        --rainbow_prompt_separators=Slanted --powerline_prompt_heads=Sharp --powerline_prompt_tails=Slanted \
        --powerline_prompt_style='Two lines, character' --prompt_connection=Disconnected \
        --powerline_right_prompt_frame=No --prompt_spacing=Sparse --icons='Few icons' --transient=No
    clear && exec fish
end

if status is-interactive
    # $PATH and other env vars are inherited from environment/login shell
    # which gets it from ~/.environment so they aren't set here

    # last value is default value
    if not functions --query fisher
        fisher-configure
    end

    # disable welcome
    set fish_greeting

    bind ctrl-shift-Z redo

    if [ -f "$__fish_config_dir/abbrs.fish" ]
        source "$__fish_config_dir/abbrs.fish"
    end
end
