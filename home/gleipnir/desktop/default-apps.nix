{ lib, ... }:
let
  defaultBrowser = "brave-browser-nightly.desktop";
  defaultImageViewer = "org.gnome.Loupe.desktop";
  defaultEditor = "nvim-kitty.desktop";
  defaultFileManager = "org.gnome.Nautilus.desktop";
  defaultPdfViewer = "okularApplication_pdf.desktop";

  browserMimes = [
    "x-scheme-handler/http"
    "x-scheme-handler/https"
    "x-scheme-handler/chrome"
    "x-scheme-handler/about"
    "x-scheme-handler/unknown"
    "x-scheme-handler/mailto"
    "text/html"
    "application/x-extension-htm"
    "application/x-extension-html"
    "application/x-extension-shtml"
    "application/xhtml+xml"
    "application/x-extension-xhtml"
    "application/x-extension-xht"
  ];

  imageMimes = [
    "image/png"
    "image/jpeg"
    "image/webp"
    "image/gif"
    "image/tiff"
  ];

  editorMimes = [
    "application/ecmascript"
    "application/jrd+json"
    "application/json-patch+json"
    "application/ld+json"
    "application/mathematica"
    "application/pkcs7-signature"
    "application/relax-ng-compact-syntax"
    "application/schema+json"
    "application/toml"
    "application/vnd.chess-pgn"
    "application/vnd.cups-ppd"
    "application/vnd.flatpak.ref"
    "application/vnd.gerber"
    "application/x-awk"
    "application/x-cdrdao-toc"
    "application/x-desktop"
    "application/x-fishscript"
    "application/x-gd-rom-cue"
    "application/x-gerber-job"
    "application/x-go-sgf"
    "application/x-godot-shader"
    "application/x-ipynb+json"
    "application/x-lyx"
    "application/x-magicpoint"
    "application/x-nautilus-link"
    "application/x-openvpn-profile"
    "application/x-php"
    "application/x-profile"
    "application/x-ruby"
    "application/x-shared-library-la"
    "application/x-troff-man"
    "application/xml-dtd"
    "chemical/x-pdb"
    "message/disposition-notification"
    "message/partial"
    "model/gltf+json"
    "model/mtl"
    "model/vrml"
    "text/calendar"
    "text/csv"
    "text/enriched"
    "text/javascript"
    "text/org"
    "text/rfc822-headers"
    "text/rust"
    "text/spreadsheet"
    "text/tcl"
    "text/turtle"
    "text/vbscript.encode"
    "text/vnd.familysearch.gedcom"
    "text/vnd.rn-realtext"
    "text/vnd.sun.j2me.app-descriptor"
    "text/vtt"
    "text/x-authors"
    "text/x-bibtex"
    "text/x-c++hdr"
    "text/x-changelog"
    "text/x-cmake"
    "text/x-common-lisp"
    "text/x-credits"
    "text/x-csharp"
    "text/x-dbus-service"
    "text/x-devicetree-source"
    "text/x-dsrc"
    "text/x-elixir"
    "text/x-erlang"
    "text/x-genie"
    "text/x-gettext-translation-template"
    "text/x-go"
    "text/x-groovy"
    "text/x-idl"
    "text/x-iptables"
    "text/x-kaitai-struct"
    "text/x-ldif"
    "text/x-literate-haskell"
    "text/x-lua"
    "text/x-matlab"
    "text/x-microdvd"
    "text/x-modelica"
    "text/x-mpl2"
    "text/x-ms-regedit"
    "text/x-nfo"
    "text/x-nimscript"
    "text/x-objcsrc"
    "text/x-ocl"
    "text/x-opencl-src"
    "text/x-patch"
    "text/x-python3"
    "text/x-readme"
    "text/x-rpm-spec"
    "text/x-sagemath"
    "text/x-scala"
    "text/x-scons"
    "text/x-setext"
    "text/x-subviewer"
    "text/x-svsrc"
    "text/x-tex"
    "text/x-todo-txt"
    "text/x-troff-mm"
    "text/x-twig"
    "text/x-typst"
    "text/x-uri"
    "text/x-vala"
    "text/x-verilog"
    "text/x.gcode"
  ];

  # Entries with a fixed, single-purpose app -- not templated since there's
  # no interchangeable "role" (each is tied to a specific account/service).
  staticDefaults = {
    "inode/directory" = defaultFileManager;
    "application/pdf" = defaultPdfViewer;
    "x-scheme-handler/discord" = "vesktop.desktop";
    "x-scheme-handler/msteams" = "teams-for-linux.desktop";
    "x-scheme-handler/mailspring" = "Mailspring.desktop";
    "message/rfc822" = "userapp-Thunderbird-C2K302.desktop";
    "x-scheme-handler/mid" = "userapp-Thunderbird-C2K302.desktop";
    "x-scheme-handler/postman" = "Postman.desktop";
    "x-scheme-handler/magnet" = "userapp-transmission-gtk-92Z4L3.desktop";
    "x-scheme-handler/claude-cli" = "claude-code-url-handler.desktop";
  };
in
{
  xdg.desktopEntries.nvim-kitty = {
    categories = [
      "Utility"
      "TextEditor"
    ];
    comment = "Edit file in nvim inside kitty";
    exec = "kitty -e nvim %f";
    icon = "nvim";
    name = "Neovim (kitty)";
    terminal = false;
    type = "Application";
  };

  xdg.mimeApps = {
    enable = true;

    defaultApplications =
      (lib.genAttrs browserMimes (_: defaultBrowser))
      // (lib.genAttrs imageMimes (_: defaultImageViewer))
      // (lib.genAttrs editorMimes (_: defaultEditor))
      // staticDefaults;

    associations.added = {
      "x-scheme-handler/http" = [ "xfce4-web-browser.desktop" ];
      "x-scheme-handler/https" = [ "xfce4-web-browser.desktop" ];
      "x-scheme-handler/mailto" = [
        "userapp-Thunderbird-CM2Y02.desktop"
        "userapp-Thunderbird-C2K302.desktop"
      ];
      "x-scheme-handler/mid" = [
        "userapp-Thunderbird-CM2Y02.desktop"
        "userapp-Thunderbird-C2K302.desktop"
      ];
      "application/x-msdownload" = [
        "wine.desktop"
        "net.lutris.Lutris.desktop"
      ];
      "application/msixbundle" = [ "wine-extension-msp.desktop" ];
      "x-scheme-handler/magnet" = [ "userapp-transmission-gtk-92Z4L3.desktop" ];
    };
  };
}
