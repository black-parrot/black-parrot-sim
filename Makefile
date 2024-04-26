TOP ?= $(shell git rev-parse --show-toplevel)

export BP_RTL_DIR   := $(TOP)/black-parrot
export BP_TOOLS_DIR := $(TOP)/black-parrot-tools
export BP_SDK_DIR   := $(TOP)/black-parrot-sdk

checkout:
	git fetch --all
	git submodule update --init
	$(MAKE) -C $(BP_RTL_DIR) checkout
	$(MAKE) -C $(BP_TOOLS_DIR) checkout
	$(MAKE) -C $(BP_SDK_DIR) checkout

prep_lite: checkout
	$(MAKE) -C $(BP_RTL_DIR) libs_lite
	$(MAKE) -C $(BP_TOOLS_DIR) tools_lite
	$(MAKE) -C $(BP_SDK_DIR) sdk_lite
	$(MAKE) -C $(BP_SDK_DIR) prog_lite

prep: prep_lite
	$(MAKE) -C $(BP_RTL_DIR) libs
	$(MAKE) -C $(BP_TOOLS_DIR) tools
	$(MAKE) -C $(BP_SDK_DIR) sdk
	$(MAKE) -C $(BP_SDK_DIR) prog

prep_bsg: prep
	$(MAKE) -C $(BP_RTL_DIR) libs_bsg
	$(MAKE) -C $(BP_TOOLS_DIR) tools_bsg
	$(MAKE) -C $(BP_SDK_DIR) sdk_bsg
	$(MAKE) -C $(BP_SDK_DIR) prog_bsg

## This target just wipes the whole repo clean.
#  Use with caution.
bleach_all:
	cd $(TOP); git clean -fdx; git submodule deinit -f .

