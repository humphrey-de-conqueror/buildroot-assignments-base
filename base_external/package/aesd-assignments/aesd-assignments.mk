
##############################################################
#
# AESD-ASSIGNMENTS
#
##############################################################

AESD_ASSIGNMENTS_VERSION = assignment-4-part-2
AESD_ASSIGNMENTS_SITE = git@github.com:humphrey-de-conqueror/aesd-assignments.git
AESD_ASSIGNMENTS_SITE_METHOD = git
AESD_ASSIGNMENTS_GIT_SUBMODULES = YES

define AESD_ASSIGNMENTS_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/finder-app clean
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/finder-app all
endef

define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/finder-app/writer \
		$(TARGET_DIR)/usr/bin/writer

	$(INSTALL) -D -m 0755 $(@D)/finder-app/finder.sh \
		$(TARGET_DIR)/usr/bin/finder.sh

	$(INSTALL) -D -m 0755 $(@D)/finder-app/finder-test.sh \
		$(TARGET_DIR)/usr/bin/finder-test.sh

	$(INSTALL) -d $(TARGET_DIR)/etc/finder-app/conf
	$(INSTALL) -m 0644 $(@D)/conf/* \
		$(TARGET_DIR)/etc/finder-app/conf/
endef

$(eval $(generic-package))
