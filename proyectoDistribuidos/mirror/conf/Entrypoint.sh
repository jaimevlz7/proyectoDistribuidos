#!/bin/bash
IFS=', ' read -r -a array <<< "${deps}"

echo "${array[@]}"

symbol=" | "
mirrorFilter="Priority (required) | Priority (important) | Priority (standard) "

for package in "${array[@]}"
do
 mirrorFilter=$mirrorFilter$symbol$package
done

echo "$mirrorFilter"

aptly mirror edit -filter="$mirrorFilter" mirror-xenial
aptly mirror update mirror-xenial
aptly snapshot create mirror-snap-xenial from mirror mirror-xenial
./scripts/publish_snapshot.sh

aptly serve

