#!/usr/bin/env bash

echo MATRIX_SCALA=$MATRIX_SCALA
sbt -DscalaJSStage=full ++$MATRIX_SCALA test publishLocal || exit 1

case "$MATRIX_SCALA" in
  3.*) echo "SKIPPING docs/test" ;;
       # ^ because there is no play-docs for Scala 3
       #   and we can't use play-docs_2.13 because then:
       #    [error] Modules were resolved with conflicting cross-version suffixes in ProjectRef(uri("file:/d/play-json/"), "docs"):
       #    [error]    com.typesafe.play:play-functional _2.13, _3.0.0-M3
       #    [error]    com.typesafe.play:play-json _2.13, _3.0.0-M3

  *) sbt ++$MATRIX_SCALA docs/test || exit 2 ;;
esac
