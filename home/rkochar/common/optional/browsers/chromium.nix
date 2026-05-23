# Migrate to ungoogled-chromium
{
  programs.chromium = {
    enable = true;
    extensions = [
      "eimadpbcbfnmbkopoojfekhnkhdbieeh"  # Dark Reader
      "bkkbcggnhapdmkeljlodobbkopceiche"  # Popup blocker
      "cjpalhdlnbpafiamejdnhcphjbkeiagm"  # UBlock Origin
    ];
    commandLineArgs = [
      "--restore-last-session"
    ];
  };
}
