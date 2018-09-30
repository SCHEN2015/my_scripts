#!/bin/bash

# Description:
# There is a bug on my laptop, sometimes the fan goes its maximum speed;
# Run this script to slow down the fan speed in such a situation.

# History:
# v1.0  2018-04-12  charles.shih  Init version

sudo bash -c "echo level 1 > /proc/acpi/ibm/fan"

