#!/bin/sh
set -eo pipefail

#Generate MD formatted tags from roles and cluster yaml files
printf "|%25s |%9s\n" "Tag name" "Used for"
echo "|--------------------------|---------"
tags=$(grep -r tags: . | perl -ne '/tags:\s\[?(([\w\-_]+,?\s?)+)/ && printf "%s ", "$1"'|\
  perl -ne 'print join "\n", split /\s|,/' | sort -u)
for tag in $tags; do
  match=$(cat docs/ansible.md | perl -ne "/^\|\s+${tag}\s\|\s+((\S+\s?)+)/ && printf \$1")
  printf "|%25s |%s\n" "${tag}" " ${match}"
done

a=1
b=2
if [ $a -gt $b ]
then
  echo $a
else
  echo $b
fi
arch=`uname -m`
if [ $arch = 'aarch64' ]
then
  docker tag kubesphere/defaultbackend-arm64:1.4 kubesphere/defaultbackend-amd64:1.4
fi

