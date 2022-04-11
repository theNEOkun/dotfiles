#!/bin/bash

(killall -e tint2) &
(sleep 1s && tint2) &
(sleep 2s && exit)
