TOP ?= $(shell git rev-parse --show-toplevel)
include $(TOP)/Makefile.common
include $(TOP)/Makefile.env

checkout::
	@$(eval export BP_INSTALL_DIR)
	@$(eval export BP_RISCV_DIR)
	@$(MAKE) -C $(BP_RTL_DIR) checkout
	@$(MAKE) -C $(BP_TOOLS_DIR) checkout
	@$(MAKE) -C $(BP_SDK_DIR) checkout

prep_lite: ## minimal preparation for simulation
prep_lite: checkout
	@$(eval export BP_INSTALL_DIR)
	@$(eval export BP_RISCV_DIR)
	@$(MAKE) -C $(BP_RTL_DIR) libs_lite
	@$(MAKE) -C $(BP_TOOLS_DIR) tools_lite
	@$(MAKE) -C $(BP_SDK_DIR) tools_lite
	@$(MAKE) -C $(BP_SDK_DIR) prog_lite

prep: ## standard preparation for simulation
prep: prep_lite
	@$(eval export BP_INSTALL_DIR)
	@$(eval export BP_RISCV_DIR)
	@$(MAKE) -C $(BP_RTL_DIR) libs
	@$(MAKE) -C $(BP_TOOLS_DIR) tools
	@$(MAKE) -C $(BP_SDK_DIR) tools
	@$(MAKE) -C $(BP_SDK_DIR) prog

prep_bsg: ## extra preparation for BSG users
prep_bsg: prep
	@$(eval export BP_INSTALL_DIR)
	@$(eval export BP_RISCV_DIR)
	@$(MAKE) -C $(BP_RTL_DIR) libs_bsg
	@$(MAKE) -C $(BP_TOOLS_DIR) tools_bsg
	@$(MAKE) -C $(BP_SDK_DIR) tools_bsg
	@$(MAKE) -C $(BP_SDK_DIR) prog_bsg

