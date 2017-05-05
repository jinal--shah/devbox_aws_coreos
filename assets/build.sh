#!/bin/sh
#
# Script allows core user to execute docker commands against
# the host's docker daemon via the docker.sock file.
#
# ... shadow pkg in non-standard repo
u=http://dl-cdn.alpinelinux.org/alpine/edge/community
repo_file=/etc/apk/repositories
dgid="$1"

if [[ -z "$dgid" ]]; then
    echo "ERROR $0: expects one param: docker gid"
    exit 1
fi
echo "... adding shadow pkg (from $u)"
echo $u >> $repo_file

apk --update --no-cache add shadow

sed -i "\#$u#d" $repo_file

userdel docker 2>/dev/null || true

groupdel docker 2>/dev/null || true

echo "INFO $0: creating docker group gid:$dgid"
groupadd --gid $dgid docker || exit 1

echo "INFO $0: adding core to docker group"
usermod -a -G $dgid core || exit 1
