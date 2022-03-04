# BlackParrot Simulation Environment

This repository is the main development meta-repository of the BlackParrot processor
[BlackParrot](https://www.github.com/black-parrot/black-parrot). It should track close to the
bleeding edge of the BlackParrot RTL and BlackParrot SDK repos. Because this is a low-level
simulation environment, there's very little else in this repo.

## Getting Started
### Tire Kick
Users who just want to test their setup and run a minimal BlackParrot test should run the following:

    # Clone the latest repo
    git clone https://github.com/black-parrot/black-parrot-sim.git
    cd black-parrot-sim

    # Install a minimal set of tools and libraries
    # For faster builds, make prep_lite -j is parallelizable!
    make prep_lite

    # From here, most operations are handled from within the black-parrot repo
    cd rtl

    # Running your first test
    make -C bp_top/syn tire_kick

This should output (roughly)

    Hello world!
    [CORE0 FSH] PASS
    [CORE0 STATS]
        clk   :                  220
        instr :                   66
        mIPC  :                  300
    All cores finished! Terminating...

# Getting started (Full)
## Prerequisites
### CentOS 7+

    yum install autoconf automake libmpc-devel mpfr-devel gmp-devel gawk \
                bison flex texinfo patchutils gcc gcc-c++ zlib-devel \
                expat-devel dtc gtkwave vim-common virtualenv

On CentOS 7, some tools provided by the base repository are too old to satisfy the requirements.
We suggest using the [Software Collections](https://wiki.centos.org/AdditionalResources/Repositories/SCL)
(SCL) to obtain newer versions.

    yum install centos-release-scl
    yum install devtoolset-9 rh-git218
    scl enable devtoolset-9 rh-git218 bash
    # To automatically enable on new terminals, add the following line to ~/.bashrc:
    # source scl_source enable devtoolset-9 rh-git218

### Ubuntu

    sudo apt-get install autoconf automake autotools-dev curl libmpc-dev \
                         libmpfr-dev libgmp-dev gawk build-essential bison \
                         flex texinfo gperf libtool patchutils bc zlib1g-dev \
                         libexpat-dev wget byacc device-tree-compiler python \
                         gtkwave vim-common virtualenv python-yaml
                         
Recent versions of Ubuntu have changed the aliases for cmake. One can either use CMAKE=cmake3 while building tools or change this variable directly in the Makefiles.

BlackParrot has been tested extensively on CentOS 7. We have many users who have used Ubuntu for
development. If not on a relatively recent version of these OSes, we suggest using a
Docker image.

Ubuntu on Windows WSL 2.0 seems to work for most things, but you may encounter errors with more complex operations. For instance, compiling Linux is known not to work in this environment. This is considered an experimental build.

## Build the toolchains
    # Clone the latest repo
    git clone https://github.com/black-parrot/black-parrot-sim.git
    cd black-parrot-sim

    # make prep is a meta-target which will build the RISC-V toolchains, programs and microcode
    #   needed for a full BlackParrot evaluation setup.
    # Users who are changing code can use the 'libs' 'prog' or 'ucode' targets as appropriate
    # For faster builds, make prep -j is parallelizable!
    # To get started as fast as possible, use 'make prep_lite' which installs a minimal set of tools
    # BSG users should instead use 'make prep_bsg', which sets up the bsg CAD environment
    make prep

    # From here, most operations are handled from within the black-parrot repo
    cd rtl

    # Running your first test
    make -C bp_top/syn build.sc sim.sc COSIM_P=1

## Continuing Onward
Additional documentation is available in the main BlackParrot repo, in the Simulation Guide:
[BlackParrot](https://github.com/black-parrot/black-parrot)

### Docker build
For a painless Ubuntu build, download and install [Docker Desktop](https://www.docker.com/products/docker-desktop) then run the following:

    git clone https://github.com/black-parrot/black-parrot-sim.git
    cd black-parrot-sim
    docker-compose build --build-arg USER_ID=$(id -u) --build-arg GROUP_ID=$(id -g) bp
    docker-compose up -d
    docker-compose exec bp su - build
    
Then follow the [Tire Kick](#-tire-kick) directions above starting with "cd black-parrot-sim" or the "Full" directions below.  The repo directory will be mounted inside the container.

# BlackParrot Repository Overview
- **rtl/** contains the BlackParrot RTL and basic simulation environment
- **sdk/** contains the BlackParrot Software Development Kit. More details can be found in the SDK
  README.md

