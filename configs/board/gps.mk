#
# Copyright (C) 2016 The CyanogenMod Project
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

# Shim
TARGET_LD_SHIM_LIBS += /system/bin/gpsd|/vendor/lib64/libsensor_shim.so

# GNSS
# TARGET_SEC_GPS_GPIO_POWER_FILE := /sys/class/sec/gps/GPS_PWR_EN/value
