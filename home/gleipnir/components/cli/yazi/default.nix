{ pkgs, inputs, ... }:
let
  yazi-plugins = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "de53d90cb2740f84ae595f93d0c4c23f8618a9e4";
    hash = "sha256-ixZKOtLOwLHLeSoEkk07TB3N57DXoVEyImR3qzGUzxQ=";
  };
  yazi-flavors = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "flavors";
    rev = "7a355f832d6dd8d755b978dc1b399da4513cf3cd";
    hash = "sha256-7ndz5nzode9XyTFALikK0nz0gJICaOyxiHok0U/gzQA=";
  };
  tokyo-night-flavor = pkgs.fetchFromGitHub {
    owner = "BennyOe";
    repo = "tokyo-night.yazi";
    rev = "5f5636427f9bb16cc3f7c5e5693c60914c73f036";
    hash = "sha256-4aNPlO5aXP8c7vks6bTlLCuyUQZ4Hx3GWtGlRmbhdto=";
  };
  relative-motions-plugin = pkgs.fetchFromGitHub {
    owner = "dedukun";
    repo = "relative-motions.yazi";
    rev = "a603d9ea924dfc0610bcf9d3129e7cba605d4501";
    hash = "sha256-9i6x/VxGOA3bB3FPieB7mQ1zGaMK5wnMhYqsq4CvaM4=";
  };
  compress-plugin = pkgs.fetchFromGitHub {
    owner = "KKV9";
    repo = "compress.yazi";
    rev = "9fc8fe0bd82e564f50eb98b95941118e7f681dc8";
    hash = "sha256-VKo4HmNp5LzOlOr+SwUXGx3WsLRUVTxE7RI7kIRKoVs=";
  };
  drag-plugin = pkgs.fetchFromGitHub {
    owner = "Joao-Queiroga";
    repo = "drag.yazi";
    rev = "65414eae6fe2e22b6db3df2955fc0addb9e5454b";
    hash = "sha256-aqFVa/+3zZK4ifVP68ojYyUsR+LYJyL+50Igl8zapXM=";
  };
in
{
  home.packages = with pkgs; [
    exiftool
    mediainfo
    ripdrag
  ];

  programs = {
    yazi = {
      enable = true;
      package = inputs.yazi.packages.${pkgs.system}.default;
      enableFishIntegration = true;
      settings = {
        preview = {
          ueberzug_offset = [ 1 2 0 0 ];
        };
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
          { on = [ "<C-n>" ]; run = "plugin drag"; desc = "Drag Files"; }
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
        drag = drag-plugin;
      };
      flavors = {
        catppuccin-mocha = "${yazi-flavors}/catppuccin-mocha.yazi";
        tokyo-night = "${tokyo-night-flavor}";
      };
      theme = {
        flavor = {
          dark = "tokyo-night";
        };
      };
      initLua = ./init.lua;
    };
  };
}
