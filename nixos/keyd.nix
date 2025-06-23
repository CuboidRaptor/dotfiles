# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  inputs,
  ...
}:

{
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [
          "258a:008b"
        ];
        settings = {
          main = {
            capslock = "esc";
            pageup = "home";
            pagedown = "end";
            home = "pageup";
            end = "pagedown";
            esc = "layer(nump)"; # this enable numpad layer
          };
          nump = {
            # numpad!
            capslock = "capslock"; # esc caps enables caps (why not)
            "1" = "f5";

            comma = "kp0";
            dot = "kpdot";
            slash = "^";
            k = "kp1";
            l = "kp2";
            semicolon = "kp3";
            i = "kp4";
            o = "kp5";
            p = "kp6";
            "8" = "kp7";
            "9" = "kp8";
            "0" = "kp9";

            rightshift = "kpplus";
            apostrophe = "kpminus";
            leftbrace = "kpasterisk";
            minus = "kpslash";

            m = "kpleftparen";
            j = "kprightparen";
            u = "macro(a n s)";
            "7" = "numlock";
          };
        };
      };
    };
  };
}
