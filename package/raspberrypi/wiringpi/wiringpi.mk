#############################################################
#
# wiringpi
#
#############################################################

WIRINGPI_VERSION = master
WIRINGPI_SITE = git://github.com/gamaral/WiringPi.git
WIRINGPI_LICENSE = LGPLv3+
WIRINGPI_LICENSE_FILES = COPYING.LESSER
WIRINGPI_INSTALL_STAGING = YES
WIRINGPI_INSTALL_TARGET = YES
WIRINGPI_CONF_OPT = -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr

define WIRINGPI_INSTALL_TARGET_CMDS
	$(HOST_DIR)/usr/bin/cmake -DCMAKE_INSTALL_PREFIX=$(TARGET_DIR)/usr -DCOMPONENT=target -P "$(@D)/cmake_install.cmake"
	mv $(@D)/install_manifest_target.txt $(@D)/install_manifest_target_target.txt
endef

define WIRINGPI_INSTALL_STAGING_CMDS
	$(HOST_DIR)/usr/bin/cmake -DCMAKE_INSTALL_PREFIX=$(STAGING_DIR)/usr -DCOMPONENT=staging -P "$(@D)/cmake_install.cmake"
	mv $(@D)/install_manifest_staging.txt $(@D)/install_manifest_staging_staging.txt

	$(HOST_DIR)/usr/bin/cmake -DCMAKE_INSTALL_PREFIX=$(STAGING_DIR)/usr -DCOMPONENT=target -P "$(@D)/cmake_install.cmake"
	mv $(@D)/install_manifest_target.txt $(@D)/install_manifest_target_staging.txt
endef

define WIRINGPI_POST_STAGING_CLEANUP
    rm $(STAGING_DIR)/usr/bin/cpio
endef

define WIRINGPI_UNINSTALL_TARGET_CMDS
	xargs rm -f < $(@D)/install_manifest_target_target.txt
endef

define WIRINGPI_UNINSTALL_STAGING_CMDS
	xargs rm -f < $(@D)/install_manifest_staging_staging.txt
	xargs rm -f < $(@D)/install_manifest_target_staging.txt
endef

$(eval $(cmake-package))
