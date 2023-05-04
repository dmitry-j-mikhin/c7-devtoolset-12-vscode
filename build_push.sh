set -ex

DOCKER_BUILDKIT=1 docker build --pull \
 --tag dmikhin/c7-devtoolset-12-vscode:latest .
docker push dmikhin/c7-devtoolset-12-vscode:latest