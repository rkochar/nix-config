# Migrate to ungoogled-chromium
{
    programs.chromium = {
        enable = true;
        extensions = [
            "eimadpbcbfnmbkopoojfekhnkhdbieeh"  # Dark Reader
            "bkkbcggnhapdmkeljlodobbkopceiche"  # Popup blocker
            "cjpalhdlnbpafiamejdnhcphjbkeiagm"  # UBlock Origin
            "aapbdbdomjkkjkaonfhkkikfgjllcleb"  # Google Translate
        ];
        # chrome://flags
        commandLineArgs = [
            "--restore-last-session"
            "--force-dark-mode"
        ];
    };
}
