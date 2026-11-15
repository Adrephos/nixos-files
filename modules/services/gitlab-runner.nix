{
  # Runs the jobs of shuuki/tsumu's pipeline, which GitLab's shared runners would bill in compute minutes.
  # The jobs ask for `image: nixos/nix:latest`, so this is the Docker executor (docker.nix enables Docker).
  #
  # Create the runner in GitLab (project Settings > CI/CD > Runners > New project runner), then put its
  # authentication token (glrt-...) in /etc/nixos-secrets/gitlab-runner as:
  #   CI_SERVER_URL=https://gitlab.com
  #   CI_SERVER_TOKEN=glrt-...
  services.gitlab-runner = {
    enable = true;
    settings.concurrent = 3;
    services.elend = {
      authenticationTokenConfigFile = "/etc/nixos-secrets/gitlab-runner";
      dockerImage = "nixos/nix:latest";
    };
  };
}
