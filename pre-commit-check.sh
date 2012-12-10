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

echo '====== Running PyFlakes ======'
bin/pyflakes src/osha.campaigntoolkit/; handle_exit

echo '====== Running pep8 =========='
bin/pep8 --ignore=E501 src/osha.campaigntoolkit/; handle_exit

if [ $EXITCODE -ne 0 ]; then
    exit 1
fi
