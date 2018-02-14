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

# Power
PRODUCT_PACKAGES += \
    power.exynos5 \
    android.hardware.power@1.0-service \
    android.hardware.power@1.0-impl \
    vendor.lineage.power@1.0-impl

# power control interface
PRODUCT_PACKAGES += \
	libpower-config \
	libzeropowersettings_jni \
	ZeroPowerSettings

# permission-updater
PRODUCT_COPY_FILES += \
    device/samsung/zero-common/power/android.hardware.power@1.0-service.rc:system/vendor/etc/init/android.hardware.power@1.0-service.rc
