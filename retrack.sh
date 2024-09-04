#!/usr/bin/env bash

echo "Untracking..."
git rm -r --cached .
echo "Retracking..."
git add .
echo "Done!"
