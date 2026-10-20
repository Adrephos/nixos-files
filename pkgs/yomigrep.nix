{
  buildGoModule,
  fetchFromGitLab,
}:
buildGoModule {
  pname = "yomigrep";
  version = "0-unstable-2026-10-11";

  src = fetchFromGitLab {
    owner = "afriguez";
    repo = "yomigrep";
    rev = "d65a20dd74eea140c94e8a1765269c2be48ecdf2";
    hash = "sha256-8RZ7Fj/vbMtaf9wxmNkZom6vNMc3vTrNrEFdSqenMg8=";
  };

  vendorHash = "sha256-cSmEs9H54ql694jXf08col0Ep4mVDiIySLv8HlHXm04=";

  meta = {
    description = "CLI Japanese dictionary grep/search tool";
    homepage = "https://gitlab.com/afriguez/yomigrep";
    mainProgram = "yomigrep";
  };
}
