# syntax=docker/dockerfile:experimental
FROM fedora:39

# ADD scripts /tmp/build
RUN --mount=type=bind,target=/tmp/build,source=scripts,ro \
    /tmp/build/build.sh

# Environment Configuration
ENV VSCODE=1 \
    WALLARM_STATIC=true

USER vscode
