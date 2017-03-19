#!/bin/sh

echo y | fly -t home set-pipeline -p pcf-start-stop -c pipeline.yml -l credentials.yml