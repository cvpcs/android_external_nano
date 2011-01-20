LOCAL_PATH:= $(call my-dir)

# ========================================================
# nano
# ========================================================
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
	src/browser.c \
	src/chars.c \
	src/color.c \
	src/cut.c \
	src/files.c \
	src/global.c \
	src/help.c \
	src/move.c \
	src/nano.c \
	src/prompt.c \
	src/rcfile.c \
	src/search.c \
	src/text.c \
	src/utils.c \
	src/winio.c
LOCAL_C_INCLUDES += \
	$(LOCAL_PATH) \
	external/clearsilver \
	external/clearsilver/util/regex \
	external/libncurses/include
LOCAL_CFLAGS += \
	-DHAVE_CONFIG_H \
	-DLOCALEDIR=\"/data/locale\" \
	-DSYSCONFDIR=\"/system/etc/nano\"
LOCAL_SHARED_LIBRARIES += \
	libncurses
LOCAL_STATIC_LIBRARIES += \
	libclearsilverregex
LOCAL_MODULE := nano
LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
LOCAL_MODULE_TAGS := eng
include $(BUILD_EXECUTABLE)


# ========================================================
# nano configs
# ========================================================
etc_files := $(shell ls -1 $(LOCAL_PATH)/etc/)

copy_to := $(addprefix $(TARGET_OUT)/etc/$(LOCAL_MODULE)/,$(etc_files))
copy_from := $(addprefix $(LOCAL_PATH)/etc/,$(etc_files))

$(copy_to) : PRIVATE_MODULE := system_etcdir
$(copy_to) : $(TARGET_OUT)/etc/$(LOCAL_MODULE)/% : $(LOCAL_PATH)/etc/% | $(ACP)
	$(transform-prebuilt-to-target)

ALL_PREBUILT += $(copy_to)

# ========================================================
include $(call all-makefiles-under,$(LOCAL_PATH))
