#!/bin/sh -e

sel=$(slop -f "-i %i -g %g")
shotgun $sel ~/Pictures/screenshots/$(date +%Y-%m-%d-h%Hm%Ms%S).png
