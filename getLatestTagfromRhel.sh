#!/bin/sh

# skopeo command to get the latest tag from the RHEL catalogue
#required: oc client, jq
# $1=image-name

skopeo list-tags docker://registry.access.redhat.com/$1 \
    | jq -r '.Tags|.|=map(select(index("latest")|not))' \
    | grep -v "source" |sort -r --version-sort \
    | grep -v "\["| grep -v "\]" \
    | head -n 1 \
    | sed  's|,||' \
    | sed 's|"||' \
    | sed 's|"||' \
    | xargs
