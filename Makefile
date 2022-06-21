TOP ?= $(shell git rev-parse --show-toplevel)

export BP_RTL_DIR   := $(TOP)/rtl
export BP_TOOLS_DIR := $(TOP)/tools
export BP_SDK_DIR   := $(TOP)/sdk

.PHONY: prep prep_bsg bleach_all

checkout:
	cd $(TOP); git submodule update --init --recursive --checkout $(BP_RTL_DIR)
	cd $(TOP); git submodule update --init --recursive --checkout $(BP_TOOLS_DIR)
	cd $(TOP); git submodule update --init --recursive --checkout $(BP_SDK_DIR)

prep_lite: checkout
	$(MAKE) -C $(BP_RTL_DIR) libs
	$(MAKE) -C $(BP_TOOLS_DIR) tools_lite
	$(MAKE) -C $(BP_SDK_DIR) sdk_lite
	$(MAKE) -C $(BP_SDK_DIR) prog

prep: prep_lite
	$(MAKE) -C $(BP_RTL_DIR) libs
	$(MAKE) -C $(BP_TOOLS_DIR) tools
	$(MAKE) -C $(BP_SDK_DIR) sdk
	$(MAKE) -C $(BP_SDK_DIR) prog

prep_bsg: prep
	$(MAKE) -C $(BP_RTL_DIR) libs
	$(MAKE) -C $(BP_TOOLS_DIR) tools_bsg
	$(MAKE) -C $(BP_SDK_DIR) sdk
	$(MAKE) -C $(BP_SDK_DIR) prog

## This target just wipes the whole repo clean.
#  Use with caution.
bleach_all:
	cd $(TOP); git clean -fdx; git submodule deinit -f .

