# BlackParrot Simulation Environment

This repository is the main development meta-repository of the BlackParrot processor
[BlackParrot](https://www.github.com/black-parrot/black-parrot).
It should track close to the bleeding edge of the BlackParrot RTL and BlackParrot SDK repos.
Because this is a bare simulation environment, there's very little else in this repo.

## Repository Overview

- **black-parrot/** contains the BlackParrot RTL and basic simulation environment
- **black-parrot-sdk/** contains the BlackParrot Software Development Kit
- **black-parrot-tools/** contains open-source tools used to augment BlackParrot simulations
- **docker/** contains files needed for a Docker-based simulation environment

For most users, the following makefile targets will be the most useful:

    make prep_lite;     # minimal set of simulation preparation
    make prep;          # standard preparation
    make prep_bsg;      # additional preparation for BSG users

There are also common Makefile targets to maintain the repository:

    make checkout;       # checkout submodules. Should be done before building tools
    make help;           # prints information about documented targets
    make bleach_all;     # wipes the whole repo clean. Use with caution

And some lesser tested, maintenance operations

    make clean;          # cleans up submodule working directory
    make tidy;           # unpatches submodules
    make bleach;         # deinitializes submodules

## Getting Started

make prep is a meta-target which will build the RISC-V toolchains, programs and microcode.
This will prepare everything needed for a full BlackParrot evaluation setup.
Users who are changing code can use the targets in tagged submodules as appropriate.
To get started as fast as possible, use 'make prep\_lite' which installs a minimal set of tools.
BSG users should instead use 'make prep\_bsg', which sets up the bsg CAD environment.

    # Clone the latest repo
    git clone https://github.com/black-parrot/black-parrot-sim.git
    make -C black-parrot-sim checkout
    # For faster builds, make prep -j is parallelizable!
    make -C black-parrot-sim prep

## Run Your First Test

Make sure your setup has completed successfully:

    # Running your first test
    make -C black-parrot-sim/black-parrot/bp_top/verilator build.verilator sim.verilator

which should output (roughly):

    Hello World!
    [CORE FSH] PASS
        terminating...
    [BSG-PASS]

## Continuing Onward

Additional documentation is available in the main BlackParrot repo: [BlackParrot](https://github.com/black-parrot/black-parrot)

## Docker Containerization

We provide Dockerfiles in docker/ to (mostly) match our internal build environments.
For performance, it is best to run natively if possible.
However, these are considered "self-documenting" examples of how to build these environments from scratch.
We also play clever tricks to allow users to mount the current repo in the image so that permissions are passed through.


    # Set the appropriate flags for your docker environment:
    #   DOCKER_PLATFORM: OS for the base image (e.g. ubuntu24.04, ...)
    #   USE_LOCAL_CREDENTIALS: whether to create the docker volume with your local uid/gid
    make -C docker docker-image; # creates a black-parrot-tools docker image
    make -C docker docker-run;   # mounts black-parrot-tools as a docker container

## Issues

For maintenance tractability we provide very limited support for this repository.
Please triage build problems to see if they are with this repo or with the submodules within.

Issue categories we appreciate:
  - Makefile bugs / incompatibilities
  - Dockerfile bugs / incompatibilities
  - OS-specific build tweaks
  - Upstream links breaking

## PRs

We will gratefully accept PRs for:
  - Submodule bumps
  - New OS support through Dockerfiles (along with necessary Makefile changes)
  - GitLab CI enhancements

