#!/bin/bash

ORIGINDIR=$PWD
BASEDIR=$(dirname $0)

cd $BASEDIR

# Clone le repository (qui doit avoir été créé précédemment dans GitLab) et pousse le code source du front-end
# Celui-ci pourra ensuite être modifié ici même

git clone http://localhost/root/appex-front-end.git
cd appex-front-end
git config --global push.default matching

# Le code source est pris de notre application-exemple
cp -r ../../../../application-exemple/front-end/* .

git add --all
git commit -m "Initial commit"
git push origin master
