set -ex

DOCKER_BUILDKIT=1 docker build --pull --no-cache \
 --tag dmikhin/c7-devtoolset-12-vscode:f39 .
docker push dmikhin/c7-devtoolset-12-vscode:f39
