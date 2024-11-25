TOP ?= $(shell git rev-parse --show-toplevel)
include $(TOP)/Makefile.common
include $(TOP)/Makefile.env

include $(BP_SIM_MK_DIR)/Makefile.docker

checkout: ## checkout submodules, but not recursively
	@$(MKDIR) -p $(BP_SIM_TOUCH_DIR)
	@$(GIT) fetch --all
	@$(GIT) submodule sync
	@$(GIT) submodule update --init
	@$(MAKE) -C $(BP_SIM_RTL_DIR) checkout
	@$(MAKE) -C $(BP_SIM_TOOLS_DIR) checkout
	@$(MAKE) -C $(BP_SIM_SDK_DIR) checkout

apply_patches: ## applies patches to submodules
apply_patches: build.patch
$(eval $(call bsg_fn_build_if_new,patch,$(CURDIR),$(BP_SIM_TOUCH_DIR)))
%/.patch_build: checkout
	@$(MAKE) -C $(BP_SIM_RTL_DIR) apply_patches
	@$(MAKE) -C $(BP_SIM_TOOLS_DIR) apply_patches
	@$(MAKE) -C $(BP_SIM_SDK_DIR) apply_patches
	@echo "Patching successful, ignore errors"

prep_lite: ## Minimal preparation for simulation
prep_lite: apply_patches
	@$(MAKE) -C $(BP_SIM_RTL_DIR) libs_lite
	@$(MAKE) -C $(BP_SIM_TOOLS_DIR) tools_lite
	@$(MAKE) -C $(BP_SIM_SDK_DIR) sdk_lite
	@$(MAKE) -C $(BP_SIM_SDK_DIR) prog_lite

prep: ## Standard preparation for simulation
prep: prep_lite
	@$(MAKE) -C $(BP_SIM_RTL_DIR) libs
	@$(MAKE) -C $(BP_SIM_TOOLS_DIR) tools
	@$(MAKE) -C $(BP_SIM_SDK_DIR) sdk
	@$(MAKE) -C $(BP_SIM_SDK_DIR) prog

prep_bsg: ## Extra preparation for BSG users
prep_bsg: prep
	@$(MAKE) -C $(BP_SIM_RTL_DIR) libs_bsg
	@$(MAKE) -C $(BP_SIM_TOOLS_DIR) tools_bsg
	@$(MAKE) -C $(BP_SIM_SDK_DIR) sdk_bsg
	@$(MAKE) -C $(BP_SIM_SDK_DIR) prog_bsg

