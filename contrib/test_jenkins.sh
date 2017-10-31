#!/bin/bash -eExl
#
# Testing script for ucx-protobuf project, to run from Jenkins CI
#
# Copyright (C) Mellanox Technologies Ltd. 2017.  ALL RIGHTS RESERVED.
#
# See file LICENSE for terms.
#
#
# Environment variables set by Jenkins CI:
#  - WORKSPACE         : path to work dir
#  - BUILD_NUMBER      : jenkins build number
#  - JOB_URL           : jenkins job url
#  - EXECUTOR_NUMBER   : number of executor within the test machine
#  - JENKINS_RUN_TESTS : whether to run unit tests
#
# TODO:
# Optional environment variables (could be set by job configuration):
#  - nworkers : number of parallel executors
#  - worker   : number of current parallel executor
#  - COV_OPT  : command line options for Coverity static checker
#

WORKSPACE=${WORKSPACE:=$PWD}
MAKE="make -j$(($(nproc) / 2 + 1))"

# Set CPU affinity to 2 cores, for performance tests
if [ -n "$EXECUTOR_NUMBER" ]; then
    AFFINITY="taskset -c $(( 2 * EXECUTOR_NUMBER ))","$(( 2 * EXECUTOR_NUMBER + 1))"
    TIMEOUT="timeout 10m"
else
    AFFINITY=""
    TIMEOUT=""
fi

echo " ==== Prepare ===="
env
cd ${WORKSPACE}
./autogen.sh
rm -rf build-test
mkdir -p build-test
cd build-test

echo "==== Build ===="
../configure
$MAKE clean
$MAKE
$MAKE distcheck

export GTEST_SHARD_INDEX=$worker
export GTEST_TOTAL_SHARDS=$nworkers
export GTEST_RANDOM_SEED=0
export GTEST_SHUFFLE=1
export GTEST_TAP=2
export GTEST_REPORT_DIR=$WORKSPACE/reports/tap

mkdir -p $GTEST_REPORT_DIR

echo "==== Running unit tests ===="
$AFFINITY $TIMEOUT make -C test gtest_ucxprotobuf

# There is no reports yet
#(cd test && rename .tap _gtest.tap *.tap && mv *.tap $GTEST_REPORT_DIR)

