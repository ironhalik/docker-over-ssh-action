# 🐳 docker-over-ssh github action

A GitHub Action to control Docker daemon remotely, over SSH

## Usage
```yaml
name: remote docker commands

on: [push]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: running docker info
        uses: ironhalik/docker-over-ssh-action@v1
        with:
          user: alice
          host: some-remote-host.tld
          key: ${{ secrets.SSH_KEY }}
          port: 1022 # Defaults to 22
          script: |
            docker info
            docker stack deploy --compose-file=some-stack.yml stack
```

## Notes
- Only SSH key authentication is supported. The SSH key can be provided as is (including the line breaks) via a secrets variable
- The action arguments support environment variables. For example:
  ```
  with:
    user: ${SSH_USER}
  ```
- Keep in mind that the `script` commands are being executed locally, inside the container - not on the remote host. Only the docker API calls are being forwarded to the remote host.
