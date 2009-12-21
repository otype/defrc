#!/bin/bash

rsync -ave ssh otype.de:/home/hgschmidt/Analysis/ ~/Analysis/
rsync -ave ssh ~/Analysis/ otype.de:/home/hgschmidt/Analysis/
