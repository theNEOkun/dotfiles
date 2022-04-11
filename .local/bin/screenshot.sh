#!/bin/sh -e

sel=$(slop -f "-i %i -g %g")
shotgun $sel ~/Pictures/screenshots/$(date +%d-%m-%Y-%s).png
