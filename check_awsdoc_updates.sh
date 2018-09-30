#!/bin/bash

# Description:
# Run this scripts periodically to check the updates of AWS instance types.

# History:
# v0.1  2018-06-07  charles.shih  Init version
# v0.2  2018-09-19  charles.shih  Change output format

set -e

timestamp=$(date +%Y%m%d%H%M%S)
filename=instance-types.${timestamp}.html
workspace=~/workspace/awsdoc_updates

title() { echo -e "\n$@\n----------------------------------------"; }

mkdir -p $workspace && cd $workspace
[ -e "instance-types.html" ] && mv instance-types.html instance-types.html.bak

title "Download the latest webpage"
wget https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html

title "Rename the file"
echo "Rename instance-types.html as $filename..."
mv instance-types.html $filename

title "Compare with the previous one"
previous=$(ls instance-types.*.html | grep -v $filename | tail -n 1)
[ -z "$previous" ] && echo "No previous one can be found..." && exit 1 
md5sum $previous $filename

title "The brief diff results"
diff -s --suppress-common-lines $previous $filename

exit 0

