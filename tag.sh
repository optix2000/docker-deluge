#!/bin/sh
set -eu

image_ref="$1"
date_tag="$(date +%Y%m%d)"
version="$(docker run --rm "$image_ref" --version | awk 'NR==1{print $2}')"
repo_tag="$(printf '%s' "$image_ref" | awk -F ':' '{print $1}')"
suffix="-$(printf '%s' "$image_ref" | awk -F ':' '{print $2}')"

if [ "$suffix" = "-latest" ]; then
  suffix=""
fi

docker tag "$image_ref" "$repo_tag:$version$suffix"
docker tag "$image_ref" "$repo_tag:$version$suffix-$date_tag"
