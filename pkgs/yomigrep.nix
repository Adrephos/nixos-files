{
  buildGoModule,
  fetchFromGitLab,
}:
buildGoModule {
  pname = "yomigrep";
  version = "0-unstable-2026-06-09";

  src = fetchFromGitLab {
    owner = "afriguez";
    repo = "yomigrep";
    rev = "76ba99495df4ed2240ed7b79da3fda74f21f4503";
    hash = "sha256-ZNh/4Akyo8M/tDmGhBfiOJvnLen9ehYHRec1GpiW4s0=";
  };

  vendorHash = null;

  meta = {
    description = "CLI Japanese dictionary grep/search tool";
    homepage = "https://gitlab.com/afriguez/yomigrep";
    mainProgram = "yomigrep";
  };
}
