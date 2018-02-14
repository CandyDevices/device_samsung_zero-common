#
# Copyright (C) 2018 TeamNexus
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# include user-sided power settings
include device/samsung/zero-common/power/settings/Android.mk

LOCAL_PATH := device/samsung/zero-common/power

#
# power-HAL
#
include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
	power.cpp \
	utils.cpp

LOCAL_SHARED_LIBRARIES := \
	libcutils \
	libhardware \
	liblog \
	libpower-config

LOCAL_MODULE               := power.$(TARGET_BOARD_PLATFORM)
LOCAL_MODULE_RELATIVE_PATH := hw
LOCAL_MODULE_TAGS          := optional
LOCAL_CFLAGS               := -Wall -Werror -Wno-unused-parameter -Wno-unused-function
LOCAL_PROPRIETARY_MODULE   := true

ifneq (,$(wildcard hardware/lineage/interfaces/power/1.0/ vendor/cmsdk/))
  LOCAL_CFLAGS += -DPOWER_HAS_LINEAGE_HINTS
endif

ifneq (,$(wildcard hardware/nexus/interfaces/power/1.0/))
  LOCAL_CFLAGS += -DPOWER_HAS_NEXUS_HINTS
endif

# Enables the advanced mutex-protection for better protection
# against problems with multithreading, may cause certain
# deadlocks, but is still recommended
# LOCAL_CFLAGS += -DPOWER_MULTITHREAD_LOCK_PROTECTION

include $(BUILD_SHARED_LIBRARY)

#
# power-configuration library
#
include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
	config.cpp \
	utils.cpp

LOCAL_C_INCLUDES += system/core/base/include/

LOCAL_SHARED_LIBRARIES := \
	libbase \
	libcutils \
	liblog

LOCAL_MODULE             := libpower-config
LOCAL_MODULE_TAGS        := optional
LOCAL_CFLAGS             := -Wall -Werror -Wno-unused-parameter -Wno-unused-function
LOCAL_PROPRIETARY_MODULE := true

include $(BUILD_SHARED_LIBRARY)
