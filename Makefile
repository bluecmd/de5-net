QPATH ?= "$(HOME)/intelFPGA/20.1/quartus"

ABS_ROOT_DIR := $(shell dirname $(abspath $(lastword $(MAKEFILE_LIST))))/

.PHONY: all syscon program flash editor defconfig menuconfig test report edit edit-clean test

all: de5net.sof report

clean:
	\rm -f de5net.sof
	\rm -fr gen
	\rm -f de5net.qsys de5net_*.qsys
	\rm -f config.tcl .config.old .qsys-clean .qsys-configured

de5net.sof: de5net.qsys de5net.sdc de5net.tcl $(wildcard ip/*/*.sv) de5net.stp config.tcl
	echo "\`define DE5NET_GIT_HASH 32'h$(shell git describe --long --always --abbrev=8)" > ip/de5net_identity/version.sv
	mkdir -p gen
	utils/apply-stp-config.py de5net.stp > gen/configured.stp
	(cd gen; rm -f *.txt *.html; $(QPATH)/bin/quartus_sh -t ../quartus.tcl)
	cp gen/output_files/de5net.sof $@
	touch $@

report:
	@echo
	@echo '  ==> Generation report <=='
	@echo
	@# 222013 removed because the ch[4] pcie Intel IP bug
	@grep '^Warning (' gen/output_files/*.rpt | \
		grep -vE '\((10762|170052|15104|12241|276020|14284|20031|18550|12251)\)' | \
		grep -vF '(222013)' | \
		grep -v  altera_avalon_i2c_csr | \
		grep -vE '(jtagm_timing_adt|jtagm_b2p_adapter)' |\
		grep -vE 'Warning \(10036\).*altera_reset_sequencer' |\
		echo ' [-] \e[32mNo synthesis warnings! Unbelievable!\e[0m'
	@echo
	@[ -f gen/violated_paths.txt ] && cat gen/violated_paths.txt \
		|| echo ' [-] \e[32mNo timing constraints violated! Yeey!\e[0m'
	@echo
	@grep -B1 '; I/O Assignment Warnings' gen/output_files/de5net.fit.rpt \
		| grep -- '---' || echo ' [-] \e[32mNo I/O assignment warnings! Awesome!\e[0m\n'
	@awk '/; I\/O Assignment Warnings/,/^$$/' gen/output_files/de5net.fit.rpt
	@echo -n ' [-] '
	@cat gen/output_files/de5net.fit.summary | grep 'Logic utilization'
	@echo -n ' [-] '
	@cat gen/output_files/de5net.fit.summary | grep 'Total block memory bits'
	@echo -n ' [-] '
	@cat gen/output_files/de5net.pow.summary | grep 'Total Thermal Power Dissipation'
	@echo
	@cat gen/fmax.txt | grep -v Thi
	@echo

# Temporarily program over JTAG
program: de5net.sof
	$(QPATH)/bin/quartus_pgm -m jtag -c 1 -o "p;$^"

# Permanently upload to DE5-Net flash
flash: de5net.sof
	QPATH=$(QPATH) utils/flash.sh $^

syscon:
	$(QPATH)/sopc_builder/bin/system-console --desktop_script=syscon.tcl -debug

ip/de5net_identity/version.sv:
	touch ip/de5net_identity/version.sv

config.tcl: .config config.py
	./config.py > config.tcl

de5net.qsys: .qsys-configured

.qsys-clean: ip/de5net_identity/version.sv de5net.tcl de5net_sfp.tcl
	# Generate clean platform files
	rm -f .qsys-configured de5net*.qsys
	$(QPATH)/sopc_builder/bin/qsys-script --script=de5net_sfp.tcl
	$(QPATH)/sopc_builder/bin/qsys-script --script=de5net.tcl
	touch $@

.qsys-configured: de5net.tcl $(wildcard de5net_*.tcl) config.tcl
	make -C $(ABS_ROOT_DIR) .qsys-clean
	$(QPATH)/sopc_builder/bin/qsys-script --script=de5net_apply_config.tcl
	rm .qsys-clean
	touch $@

edit-clean: .qsys-clean
	$(QPATH)/sopc_builder/bin/qsys-edit de5net.qsys

edit: de5net.qsys
	$(QPATH)/sopc_builder/bin/qsys-edit de5net.qsys

edit-stp: de5net.stp
	$(QPATH)/bin/quartus_stpw de5net.stp

stp: gen/configured.stp
	$(QPATH)/bin/quartus_stpw gen/configured.stp

menuconfig: .config
	MENUCONFIG_STYLE=aquatic menuconfig

defconfig:
	cp defconfig .config

.config:
	cp defconfig .config

test: test-freq_gauge

test-%: ip/%
	make QPATH=${QPATH} -C "$<" test
