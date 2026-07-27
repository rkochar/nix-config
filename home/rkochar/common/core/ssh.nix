# FIXME(starter): adjust to you security requirements
{
config,
...
}:
{
    programs.ssh =
        {
            enable = true;
            enableDefaultConfig = false;

            matchBlocks."*" = {
                forwardAgent = false;
                addKeysToAgent = "no";
                compression = false;
                serverAliveInterval = 0;
                serverAliveCountMax = 3;
                hashKnownHosts = false;
                userKnownHostsFile = "~/.ssh/known_hosts";
                controlMaster = "no";
                controlPath = "~/.ssh/master-%r@%n:%p";
                controlPersist = "no";
            };

            # controlMaster = "auto";
            # controlPath = "${config.home.homeDirectory}/.ssh/sockets/S.%r@%h:%p";
            # controlPersist = "20m";
            # # Avoids infinite hang if control socket connection interrupted. ex: vpn goes down/up
            # serverAliveCountMax = 3;
            # serverAliveInterval = 5; # 3 * 5s
            # hashKnownHosts = true;
            # addKeysToAgent = "yes";
        };
    # home.file = {
    #   ".ssh/config.d/.keep".text = "# Managed by Home Manager";
    #   ".ssh/sockets/.keep".text = "# Managed by Home Manager";
    # };
}
