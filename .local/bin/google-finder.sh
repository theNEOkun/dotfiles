#!/bin/bash

rofi -dmenu -p "Search" | xargs -I{} searcher -g {}
