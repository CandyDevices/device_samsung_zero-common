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

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE               := android.hardware.power@1.0-service.zero
LOCAL_MODULE_RELATIVE_PATH := hw
LOCAL_MODULE_TAGS          := optional
LOCAL_PROPRIETARY_MODULE   := true

LOCAL_INIT_RC := android.hardware.power@1.0-service.zero.rc

LOCAL_SRC_FILES := \
	Service.cpp \
	Power.cpp \
	Profiles.cpp \
	Utils.cpp

LOCAL_SHARED_LIBRARIES := \
	libbase \
	libcutils \
	libdl \
	libhardware \
	libhidlbase \
	libhidltransport \
	liblog \
	libutils \
	android.hardware.power@1.0 \
	vendor.candy.power@1.0

LOCAL_CFLAGS := -Wall -Werror -Wno-unused-parameter -Wno-unused-function

ifneq (,$(wildcard hardware/candy/interfaces/power/1.0/))
  LOCAL_CFLAGS += -DPOWER_HAS_CANDY_HINTS
endif

ifneq (,$(wildcard hardware/nexus/interfaces/power/1.0/))
  LOCAL_CFLAGS += -DPOWER_HAS_NEXUS_HINTS
endif

# Enables mutex-protection against multithreading-problems
# but may cause deadlocks while booting. Recommended if 
# problems can be traced back to overlapping HAL-calls
# LOCAL_CFLAGS += -DLOCK_PROTECTION

# Enforces strict limitations of rules present in power-HAL.
# This may cause errors but ensures the stability of the
# power-HAL
LOCAL_CFLAGS += -DSTRICT_BEHAVIOUR

LOCAL_CFLAGS += -DNR_CPUS=$(TARGET_NR_CPUS)

include $(BUILD_EXECUTABLE)
