{ pkgs, inputs, ... }:
let
  yazi-plugins = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "86d28e4fb4f25f36cc501b8cb0badb37a6b14263";
    hash = "sha256-m/gJTDm0cVkIdcQ1ZJliPqBhNKoCW1FciLkuq7D1mxo=";
  };
  yazi-flavors = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "flavors";
    rev = "d04a298a8d4ada755816cb1a8cfb74dd46ef7124";
    hash = "sha256-m3yk6OcJ9vbCwtxkMRVUDhMMTOwaBFlqWDxGqX2Kyvc=";
  };
  relative-motions-plugin = pkgs.fetchFromGitHub {
    owner = "dedukun";
    repo = "relative-motions.yazi";
    rev = "2e3b6172e6226e0db96aea12d09dea2d2e443fea";
    hash = "sha256-v0e06ieBKNmt9DATdL7R4AyVFa9DlNBwpfME3LHozLA=";
  };
  compress-plugin = pkgs.fetchFromGitHub {
    owner = "KKV9";
    repo = "compress.yazi";
    rev = "9fc8fe0bd82e564f50eb98b95941118e7f681dc8";
    hash = "sha256-VKo4HmNp5LzOlOr+SwUXGx3WsLRUVTxE7RI7kIRKoVs=";
  };
in
{
  home.packages = with pkgs; [
    exiftool
    mediainfo
  ];

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
          { on = [ "C" ]; run = ''shell -- copy-img "$@"''; }
          { on = [ "c" "m" ]; run = "plugin chmod"; desc = "Chmod on selected files"; }
          { on = "<C-n>"; run = ''shell -- dragon-drop -x -i -T "$1"''; }
          { on = [ "g" "r" ]; run = "shell -- ya emit cd \"$(git rev-parse --show-toplevel)\""; desc = "Go root of the git repo"; }

          { on = [ "c" "a" "a" ]; run = "plugin compress"; desc = "Archive selected files"; }
          { on = [ "c" "a" "p" ]; run = "plugin compress -p"; desc = "Archive selected files (password)"; }
          { on = [ "c" "a" "h" ]; run = "plugin compress -ph"; desc = "Archive selected files (password+header)"; }
          { on = [ "c" "a" "l" ]; run = "plugin compress -l"; desc = "Archive selected files (compression level)"; }
          { on = [ "c" "a" "u" ]; run = "plugin compress -phl"; desc = "Archive selected files (password+header+level)"; }
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
        compress = compress-plugin;
      };
      flavors = {
        catppuccin-mocha = "${yazi-flavors}/catppuccin-mocha.yazi";
      };
      theme = {
        flavor = {
          dark = "catppuccin-mocha";
        };
      };
      initLua = ./init.lua;
    };
  };
}
