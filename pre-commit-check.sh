#!/bin/bash

function handle_exit {
    if [ $? -ne 0 ]; then
        EXITCODE=1
    fi
}

EXITCODE=0

echo 'Running tests'
bin/test -s osha.campaigntoolkit; handle_exit

echo '====== Running ZPTLint ======'
for pt in `find src/osha.campaigntoolkit/ -name "*.pt"` ; do bin/zptlint $pt; done

echo '====== Running flake8 =========='
bin/flake8 --ignore=E501 src/osha.campaigntoolkit/ --exclude=Products.CMFPlone.skins.plone_scripts.livesearch_reply.py; handle_exit

if [ $EXITCODE -ne 0 ]; then
    exit 1
fi
