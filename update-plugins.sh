#!/bin/bash

FILES=`find .. -name pom.xml |grep -v target`

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

for f in $FILES; do 
  echo "check out: $f"
  cd `dirname $f`
  git checkout pom.xml
  echo "updating: $f"
  xml ed -P -N x=http://maven.apache.org/POM/4.0.0 -u "/x:project/x:build/x:plugins/x:plugin[x:artifactId='maven-release-plugin']/x:version" -v 2.5.1 pom.xml > pom.xml-new
  mv pom.xml-new pom.xml
  xml ed -P -N x=http://maven.apache.org/POM/4.0.0 -d "/x:project/x:build/x:plugins/x:plugin[x:artifactId='maven-release-plugin']/x:dependencies" pom.xml > pom.xml-new
  mv pom.xml-new pom.xml
  xml ed -P -N x=http://maven.apache.org/POM/4.0.0 -u "/x:project/x:build/x:plugins/x:plugin[x:artifactId='nexus-staging-maven-plugin']/x:version" -v 1.6.5 pom.xml > pom.xml-new
  mv pom.xml-new pom.xml
  cd $DIR
done
