{ pkgs, inputs, ... }:
let
  yazi-plugins = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "86d28e4fb4f25f36cc501b8cb0badb37a6b14263";
    hash = "sha256-m/gJTDm0cVkIdcQ1ZJliPqBhNKoCW1FciLkuq7D1mxo=";
  };
  relative-motions-plugin = pkgs.fetchFromGitHub {
    owner = "dedukun";
    repo = "relative-motions.yazi";
    rev = "2e3b6172e6226e0db96aea12d09dea2d2e443fea";
    hash = "sha256-v0e06ieBKNmt9DATdL7R4AyVFa9DlNBwpfME3LHozLA=";
  };
in
{
  programs = {
    yazi = {
      enable = true;
      package = inputs.yazi.packages.${pkgs.system}.default;
      enableFishIntegration = true;
      settings = {
        mgr = {
          show_hidden = true;
          sort_by = "mtime";
          sort_dir_first = true;
          sort_reverse = true;
        };
        plugin.prepend_previewers = [
          { name = "*.tar*"; run = ''piper --format=url -- tar tf "$1"''; }
          { name = "*.csv"; run = ''piper -- bat -p --color=always "$1"''; }
          { name = "*.md"; run = ''piper -- CLICOLOR_FORCE=1 glow -w=$w -s=dark "$1"''; }
          {
            name = "*/";
            run = ''piper -- eza -TL=3 --color=always --icons=always --group-directories-first --no-quotes "$1"'';
          }
        ];
        plugin.prepend_fetchers = [
          { id = "git"; name = "*"; run = "git"; }
          { id = "git"; name = "*/"; run = "git"; }
        ];
      };
      keymap = {
        mgr.prepend_keymap = [
          { on = [ "M" ]; run = "plugin mount"; }
          { on = [ "+" ]; run = "plugin zoom 1"; }
          { on = [ "-" ]; run = "plugin zoom -1"; }
          { on = [ "m" ]; run = "plugin relative-motions"; }
          { on = [ "1" ]; run = "plugin relative-motions 1"; }
          { on = [ "2" ]; run = "plugin relative-motions 2"; }
          { on = [ "3" ]; run = "plugin relative-motions 3"; }
          { on = [ "4" ]; run = "plugin relative-motions 4"; }
          { on = [ "5" ]; run = "plugin relative-motions 5"; }
          { on = [ "6" ]; run = "plugin relative-motions 6"; }
          { on = [ "7" ]; run = "plugin relative-motions 7"; }
          { on = [ "8" ]; run = "plugin relative-motions 8"; }
          { on = [ "9" ]; run = "plugin relative-motions 9"; }
          { on = [ "C" ]; run = "shell -- cb copy $@"; }
        ];
      };
      plugins = {
        mount = pkgs.yaziPlugins.mount;
        zoom = "${yazi-plugins}/zoom.yazi";
        git = "${yazi-plugins}/git.yazi";
        chmod = "${yazi-plugins}/chmod.yazi";
        piper = "${yazi-plugins}/piper.yazi";
        full-border = "${yazi-plugins}/full-border.yazi";
        relative-motions = relative-motions-plugin;
      };
      initLua = ./init.lua;
    };
  };
}
