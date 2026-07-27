{
    config,
    ...
}:
{
    programs.firefox = {
        enable = true;
        configPath = "${config.xdg.configHome}/mozilla/firefox";
    };

    xdg.mimeApps.defaultApplications = {
        "text/html" = [ "firefox.desktop" ];
        "text/xml" = [ "firefox.desktop" ];
        "x-scheme-handler/http" = [ "firefox.desktop" ];
        "x-scheme-handler/https" = [ "firefox.desktop" ];
    };
}
