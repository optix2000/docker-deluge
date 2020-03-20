#!/bin/sh
DATE=$(date +%Y%m%d)
VERSION=$(docker run --rm $1 --version | awk 'NR==1{print $2}')
TAG=$(echo $1 | awk -F ":" '{print $1}')
SUFFIX="-$(echo $1 | awk -F ":" '{print $2}')"
if [ $SUFFIX = '-latest' ]; then
  SUFFIX=''
fi;
docker tag $1 $TAG:$VERSION$SUFFIX
docker tag $1 $TAG:$VERSION-$DATE$SUFFIX
