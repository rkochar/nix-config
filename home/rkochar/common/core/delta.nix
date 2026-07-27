{
    programs.delta = {
        enable = true;
        enableGitIntegration = true;
        enableJujutsuIntegration = true;

        options = {
            navigate = true;
            side-by-side = true;
            # dark = true;  # auto-detect
            hyperlinks = true;
            line-numbers = true;
            # diff-so-fancy = true;

            # https://dandavison.github.io/delta/color-moved-support.html
            map-styles = "bold purple => syntax magenta, bold cyan => syntax blue";

            decorations = {
                commit-decoration-style = "bold yellow box ul";
                file-decoration-style = "none";
                file-style = "bold yellow ul";
                hunk-header-decoration-style = "yellow box";
            };
        };
    };
}
