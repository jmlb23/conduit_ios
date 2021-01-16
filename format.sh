#!/bin/sh

if which swift-format >/dev/null; then
    swift-format -m format -i -r .
else
    echo "warning: swift-format not installed"
fi
