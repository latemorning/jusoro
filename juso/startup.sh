#!/bin/sh
SOLR_JAVA_HOME=../../jdk1.8.0_102_linux64
SOLR_TIMEZONE=KST-09:00:00

export SOLR_JAVA_HOME
export SOLR_TIMEZONE

./solr start -f -p 8983 -m 2g

