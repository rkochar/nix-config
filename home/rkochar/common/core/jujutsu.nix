{
    pkgs,
    ...
}:
{
    programs.jujutsu = {
        enable = true;
        settings = {
            user = {
                name = "Rahul Kochar";
                email = "rkochar9@gmail.com";
            };
        };
    };
}
