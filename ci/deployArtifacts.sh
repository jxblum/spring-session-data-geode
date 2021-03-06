#!/bin/bash -x

set -eou pipefail

echo "Deploying artifacts on host [$HOSTNAME]"

# User ID 1001 is "jenkins"
# Group ID 1001 is "jenkins"
# Syntax: `chown -R userId:groupId .`
chown -R 1001:1001 .

GRADLE_OPTS="-Duser.name=jenkins -Djava.io.tmpdir=/tmp -Dgradle.user.home=/tmp/geode/session/artifacts-gradle-cache" \
  ./gradlew deployArtifacts finalizeDeployArtifacts --no-build-cache --no-configuration-cache --no-daemon --stacktrace \
    -PartifactoryUsername=$ARTIFACTORY_USERNAME \
    -PartifactoryPassword=$ARTIFACTORY_PASSWORD \
    -PossrhUsername=$OSSRH_USERNAME \
    -PossrhPassword=$OSSRH_PASSWORD \
    -Psigning.keyId=$SPRING_SIGNING_KEYID \
    -Psigning.password=$SIGNING_PASSWORD \
    -Psigning.secretKeyRingFile=$SIGNING_KEYRING_FILE
