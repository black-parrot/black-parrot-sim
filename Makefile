TOP ?= $(shell git rev-parse --show-toplevel)
include $(TOP)/Makefile.common
include $(TOP)/Makefile.env

include $(BP_SIM_MK_DIR)/Makefile.docker

checkout: ## checkout submodules, but not recursively
	@$(MKDIR) -p $(BP_SIM_TOUCH_DIR)
	@$(GIT) fetch --all
	@$(GIT) submodule sync
	@$(GIT) submodule update --init
	@$(MAKE) -C $(BP_SIM_RTL_DIR) checkout BP_RTL_DIR=$(BP_SIM_RTL_DIR)
	@$(MAKE) -C $(BP_SIM_TOOLS_DIR) checkout BP_TOOLS_DIR=$(BP_SIM_TOOLS_DIR)
	@$(MAKE) -C $(BP_SIM_SDK_DIR) checkout BP_SDK_DIR=$(BP_SIM_SDK_DIR)

apply_patches: ## applies patches to submodules
apply_patches: build.patch
$(eval $(call bsg_fn_build_if_new,patch,$(CURDIR),$(BP_SIM_TOUCH_DIR)))
%/.patch_build: checkout
	@$(MAKE) -C $(BP_SIM_RTL_DIR) apply_patches BP_RTL_DIR=$(BP_SIM_RTL_DIR)
	@$(MAKE) -C $(BP_SIM_TOOLS_DIR) apply_patches BP_TOOLS_DIR=$(BP_SIM_TOOLS_DIR)
	@$(MAKE) -C $(BP_SIM_SDK_DIR) apply_patches BP_SDK_DIR=$(BP_SIM_SDK_DIR)
	@echo "Patching successful, ignore errors"

prep_lite: ## Minimal preparation for simulation
prep_lite: apply_patches
	@$(MAKE) -C $(BP_SIM_RTL_DIR) libs_lite BP_RTL_DIR=$(BP_SIM_RTL_DIR)
	@$(MAKE) -C $(BP_SIM_TOOLS_DIR) tools_lite BP_TOOLS_DIR=$(BP_SIM_TOOLS_DIR)
	@$(MAKE) -C $(BP_SIM_SDK_DIR) sdk_lite BP_SDK_DIR=$(BP_SIM_SDK_DIR)
	@$(MAKE) -C $(BP_SIM_SDK_DIR) prog_lite BP_SDK_DIR=$(BP_SIM_SDK_DIR)

prep: ## Standard preparation for simulation
prep: prep_lite
	@$(MAKE) -C $(BP_SIM_RTL_DIR) libs BP_RTL_DIR=$(BP_SIM_RTL_DIR)
	@$(MAKE) -C $(BP_SIM_TOOLS_DIR) tools BP_TOOLS_DIR=$(BP_SIM_TOOLS_DIR)
	@$(MAKE) -C $(BP_SIM_SDK_DIR) sdk BP_SDK_DIR=$(BP_SIM_SDK_DIR)
	@$(MAKE) -C $(BP_SIM_SDK_DIR) prog BP_SDK_DIR=$(BP_SIM_SDK_DIR)

prep_bsg: ## Extra preparation for BSG users
prep_bsg: prep
	@$(MAKE) -C $(BP_SIM_RTL_DIR) libs_bsg BP_RTL_DIR=$(BP_SIM_RTL_DIR)
	@$(MAKE) -C $(BP_SIM_TOOLS_DIR) tools_bsg BP_TOOLS_DIR=$(BP_SIM_TOOLS_DIR)
	@$(MAKE) -C $(BP_SIM_SDK_DIR) sdk_bsg BP_SDK_DIR=$(BP_SIM_SDK_DIR)
	@$(MAKE) -C $(BP_SIM_SDK_DIR) prog_bsg BP_SDK_DIR=$(BP_SIM_SDK_DIR)

