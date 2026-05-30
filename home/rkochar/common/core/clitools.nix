{
    config,
    ...
}:
{
    programs.bat = {
        enable = true;
    };

    programs.fd = {
        enable = true;
    };

    programs.fzf = {
        enable = true;
    };

    programs.ripgrep = {
        enable = true;
    };

    programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
    };
}
