#!/bin/sh -e

sel=$(slop -f "-i %i -g %g")
shotgun $sel ~/Pictures/screenshots/$(date +%Y-%m-%d-h%Im%Ms%S).png
