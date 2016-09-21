#!/bin/bash
sed -ne 's/.*\(http[^"]*\).*/\1/p' $1 | grep .html
