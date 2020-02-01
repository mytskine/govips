#!/bin/bash

# Generates Go bindings for all the Vips operators
# that have bindings for their argument types.

echo "Requires: Python2 GObject Inspection, libvips 8+ devel"
echo "     e.g. apt install python-gi libvips-dev"

echo Generating the operators...
python2 scripts/gen-operators.py > pkg/vips/operators.go
echo Formating the Go source code...
gofmt -s -w pkg/vips/operators.go
